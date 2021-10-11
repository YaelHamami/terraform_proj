# Hub vnet section.
locals {
  hub_vnet_address = "10.0.0.0/16"
  hub_vnet_name = "hub-vnet"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  address_space       = [local.hub_vnet_address]

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

# Vm Subnet.
locals {
  hub_vm_subnet_name = "hub_vm_subnet"
  hub_vm_subnet_address = "10.0.3.0/24"
}

resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = local.hub_vm_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.hub_vm_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}

# Firewall subnet.
locals {
  firewall_subnet_name = "AzureFirewallSubnet"
  firewall_subnet_address = "10.0.4.0/26"
}
resource "azurerm_subnet" "hub_AzureFirewallSubnet" {
  name                 = local.firewall_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.firewall_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}

# Vm in the hub section.
locals {
  hub_nic_name   = "hub-vm-nic"
  hub_vm_name = "hub-vm"
  hub_vm_disk_caching = "ReadWrite"
  hub_vm_size = "Standard_B2s"
  hub_vm_publisher = "Canonical"
  hub_vm_offer     = "UbuntuServer"
  hub_vm_sku       = "16.04-LTS"
  hub_vm_version   = "latest"
  hub_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_hub" {
  source = "./modules/vm"
  location = local.all_resources_location
  rg_name = local.rg_name
  nic_name   = local.hub_nic_name

  vm_name = local.hub_vm_name

  vm_image_offer = local.hub_vm_offer
  vm_image_publisher = local.hub_vm_publisher
  vm_image_sku = local.hub_vm_sku
  vm_image_version = local.hub_vm_version
  vm_disk_caching = local.hub_vm_disk_caching
  vm_disk_storage_account_type = local.hub_vm_disk_storage_account_type

  vm_size = local.hub_vm_size
  vm_subnet_id = azurerm_subnet.hub_vm_subnet.id

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on = [azurerm_subnet.hub_vm_subnet]
}

