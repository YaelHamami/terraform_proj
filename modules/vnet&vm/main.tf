resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address]
}

resource "azurerm_subnet" "hub_gw_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.subnet_address]
}

resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.vm_subnet_address]
}

resource "azurerm_network_interface" "sample_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = local.id_conf_name
    subnet_id                     = azurerm_subnet.hub_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

locals {
  id_conf_name = "testconfiguration1"
  vm_size = "Standard_B2s"
  disk_caching = "ReadWrite"
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
  size                  = local.vm_size

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = local.disk_name
    caching              = local.disk_caching
    storage_account_type = "Standard_LRS"
  }

  admin_username                  = local.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = false
}

resource "azurerm_public_ip" "gw_public_ip" {
  name                = var.gw_public_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "hub_gw" {
  name                = var.gw_name
  location            = var.location
  resource_group_name = var.rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"
  generation = "Generation1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          =  azurerm_public_ip.gw_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub_gw_subnet.id
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]
    vpn_client_protocols = ["OpenVPN"]

    aad_tenant = "https://login.microsoftonline.com/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
    aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    aad_issuer = "https://sts.windows.net/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
  }
}