# Resource group section.
locals {
  hub_resource_group_name = "proj_hub_resource_group"
}

resource "azurerm_resource_group" "hub_resource_group" {
  name     = local.hub_resource_group_name
  location = local.location

  tags = {}
}
# Hub vnet section.
locals {
  hub_virtual_network_address = ["10.0.0.0/16"]
  hub_vnet_address            = "10.0.0.0/16"
  hub_vnet_name               = "hub-vnet"
}
//TODO: צריך לנשות בכל רפרנס ל module במקום resource
module "hub_vnet" {
  source                        = "./modules/vnet"
  location                      = local.location
  resource_group_name           = local.hub_resource_group_name
  subnet_address_prefixes       = local.hub_vm_subnet_address_prefixes
  subnet_name                   = local.hub_vm_subnet_name
  virtual_network_address_space = local.hub_virtual_network_address
  virtual_network_name          = local.hub_vnet_name

  depends_on = [azurerm_resource_group.hub_resource_group]
}

/*resource "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.hub_vnet_address]

  tags = {}

  depends_on = [azurerm_resource_group.yael_proj_rg]
}*/

# Vm Subnet.
locals {
  hub_vm_subnet_name             = "hub_vm_subnet"
  hub_vm_subnet_address          = "10.0.3.0/24"
  hub_vm_subnet_address_prefixes = ["10.0.3.0/24"]
}

/*resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = local.hub_vm_subnet_name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.hub_vm_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}*/

# Vm in the hub section.
locals {
  hub_nic_name                     = "hub-vm-nic"
  hub_vm_name                      = "hub-vm"
  hub_vm_disk_caching              = "ReadWrite"
  hub_vm_size                      = "Standard_B2s"
  hub_vm_publisher                 = "Canonical"
  hub_vm_offer                     = "UbuntuServer"
  hub_vm_sku                       = "16.04-LTS"
  hub_vm_version                   = "latest"
  hub_vm_disk_storage_account_type = "Standard_LRS"
  #  hub_vm_enable_ip_forwarding = true
}

module "vm_of_hub" {
  source              = "./modules/vm"
  location            = local.location
  resource_group_name = local.hub_resource_group_name
  nic_name            = local.hub_nic_name
  // enable_ip_forwarding = local.hub_vm_enable_ip_forwarding

  vm_name                      = local.hub_vm_name
  vm_image_offer               = local.hub_vm_offer
  vm_image_publisher           = local.hub_vm_publisher
  vm_image_sku                 = local.hub_vm_sku
  vm_image_version             = local.hub_vm_version
  vm_disk_caching              = local.hub_vm_disk_caching
  vm_disk_storage_account_type = local.hub_vm_disk_storage_account_type

  vm_size      = local.hub_vm_size
  vm_subnet_id = module.hub_vnet.sub-virtual_network_id

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on = [module.hub_vnet]
}

#Hub nsg to vm subnet.
locals {
  hub_nsg_security_rules = {
    spoke_subnet_mask = local.spoke_vnet_address,
  }
}

module "hub_network_security_group" {
  source               = "./modules/nsg"
  security_group_name  = "hub_network_security_group"
  location             = local.location
  associated_subnet_id = module.hub_vnet.sub-virtual_network_id
  resource_group_name  = local.hub_resource_group_name
  security_rules       = jsondecode(templatefile("./network_security_rules/hub.json", local.hub_nsg_security_rules)).security_rules

  depends_on = [azurerm_resource_group.hub_resource_group, module.hub_vnet]
}

locals {
  map_hub_routes = {
    fw_private_ip = module.hub_firewall.private_ip, spoke_subnet_mask = local.spoke_vnet_address,
  }
}

module "hub_route_table" {
  source               = "./modules/route_table"
  associated_subnet_id = module.hub_vnet.sub-virtual_network_id
  location             = local.location
  resource_group_name  = local.hub_resource_group_name
  routes               = jsondecode(templatefile("./routes/hub.json", local.map_hub_routes)).routes
  route_table_name     = "hub_route_table"

  depends_on = [module.hub_vnet, module.hub_firewall]
}

