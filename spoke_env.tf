# Spoke vnet section.
locals {
  spoke_vnet_name = "spoke-vnet"
  spoke_vnet_address = "20.0.0.0/16"
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = local.spoke_vnet_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  address_space       = [local.spoke_vnet_address]

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

# Subnet of the spoke vnet (a vm will be in it).
locals {
  spoke_vm_subnet_name = "spoke-vm-subnet"
  spoke_vm_subnet_address = "20.0.3.0/24"
}

resource "azurerm_subnet" "spoke_vm_subnet" {
  name                 = local.spoke_vm_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.spoke_vnet_name
  address_prefixes     = [local.spoke_vm_subnet_address]

  depends_on = [azurerm_virtual_network.spoke_vnet]
}

# Vm in the spoke section.
locals {
  spoke_nic_name   = "spoke-vm-nic"
  spoke_vm_name = "spoke-vm"
  spoke_vm_disk_caching = "ReadWrite"
  spoke_vm_size = "Standard_B2s"
  spoke_vm_publisher = "Canonical"
  spoke_vm_offer     = "UbuntuServer"
  spoke_vm_sku       = "16.04-LTS"
  spoke_vm_version   = "latest"
  spoke_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_spoke" {
  source = "./modules/vm"
  location = local.all_resources_location
  rg_name = local.rg_name
  nic_name   = local.spoke_nic_name

  vm_name = local.spoke_vm_name

  vm_image_offer = local.spoke_vm_offer
  vm_image_publisher = local.spoke_vm_publisher
  vm_image_sku = local.spoke_vm_sku
  vm_image_version = local.spoke_vm_version
  vm_disk_caching = local.spoke_vm_disk_caching
  vm_disk_storage_account_type = local.spoke_vm_disk_storage_account_type

  vm_size = local.spoke_vm_size
  vm_subnet_id = azurerm_subnet.spoke_vm_subnet.id

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on = [azurerm_subnet.spoke_vm_subnet]

}