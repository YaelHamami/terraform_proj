resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address]
}

resource "azurerm_subnet" "hub_gw_subnet" {
  name                 = var.gw_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.gw_subnet_address]
}

resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.vm_subnet_address]
}

locals {
  nic_private_ip_address_allocation = "Dynamic"
}

resource "azurerm_network_interface" "sample_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = local.id_conf_name
    subnet_id                     = azurerm_subnet.hub_vm_subnet.id
    private_ip_address_allocation = local.nic_private_ip_address_allocation
  }
}

locals {
  id_conf_name = "testconfiguration1"
  disk_name ="osdisk${var.vm_name}"
  admin_username = "testadmin"
  admin_password = "Password1234!"
}

resource "azurerm_linux_virtual_machine" "sample_vm" {
  computer_name         = var.vm_name
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.sample_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_image_publisher //"Canonical"
    offer     = var.vm_image_offer //"UbuntuServer"
    sku       = var.vm_image_sku //"16.04-LTS"
    version   = var.vm_image_version //"latest"
  }

  os_disk {
    name                 = local.disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_storage_account_type //"Standard_LRS"
  }

  admin_username                  = local.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = false
}

locals {
  gw_public_ip_allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "gw_public_ip" {
  name                = var.gw_public_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method = local.gw_public_ip_allocation_method
}

locals {
  gw_type = "Vpn"
  vpn_type = "RouteBased"
  gw_sku = "VpnGw1"
  gw_generation = "Generation1"
  ip_config_name = "vnetGatewayConfig${var.gw_name}"
  gw_private_ip_address_allocation = "Dynamic"
  vpn_client_protocols = ["OpenVPN"]
}

resource "azurerm_virtual_network_gateway" "hub_gw" {
  name                = var.gw_name
  location            = var.location
  resource_group_name = var.rg_name

  type     = local.gw_type
  vpn_type = local.vpn_type

  active_active = false
  enable_bgp    = false
  sku           = local.gw_sku
  generation = local.gw_generation

  ip_configuration {
    name                          = local.ip_config_name
    public_ip_address_id          =  azurerm_public_ip.gw_public_ip.id
    private_ip_address_allocation = local.gw_private_ip_address_allocation
    subnet_id                     = azurerm_subnet.hub_gw_subnet.id
  }

  vpn_client_configuration {
    address_space = var.gw_vpn_address_space
    vpn_client_protocols = local.vpn_client_protocols

    aad_tenant = var.aad_tenant_gw
    aad_audience = var.aad_audience_gw
    aad_issuer = var.aad_issuer_gw
  }
}