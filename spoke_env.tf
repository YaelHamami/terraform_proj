locals {
  spoke_resource_group_name = "proj_spoke_resource_group"
}

resource "azurerm_resource_group" "spoke_resource_group" {
  name     = local.spoke_resource_group_name
  location = local.location

  tags = {}
}

# Spoke vnet.
locals {
  spoke_vnet_name               = "spoke-vnet"
  spoke_vnet_address            = "10.1.0.0/16"
  spoke_virtual_network_address = ["10.1.0.0/16"]
}

//TODO: למחוק משתנים לא נחוצים
module "spoke_vnet" {
  source                        = "./modules/vnet"
  location                      = local.location
  resource_group_name           = local.spoke_resource_group_name
  subnet_address_prefixes       = local.spoke_vm_subnet_address_prefixes
  subnet_name                   = local.spoke_vm_subnet_name
  virtual_network_address_space = local.spoke_virtual_network_address
  virtual_network_name          = local.spoke_vnet_name

  depends_on = [azurerm_resource_group.spoke_resource_group]
}

# Subnet of the spoke vnet (a vm will be in it).
locals {
  spoke_vm_subnet_name             = "spoke-vm-subnet"
  spoke_vm_subnet_address          = "10.1.3.0/24"
  spoke_vm_subnet_address_prefixes = ["10.1.3.0/24"]
}

# Vm in the spoke section.
locals {
  spoke_nic_name                     = "spoke-vm-nic"
  spoke_vm_name                      = "spoke-vm"
  spoke_vm_disk_caching              = "ReadWrite"
  spoke_vm_size                      = "Standard_B2s"
  spoke_vm_publisher                 = "Canonical"
  spoke_vm_offer                     = "UbuntuServer"
  spoke_vm_sku                       = "16.04-LTS"
  spoke_vm_version                   = "latest"
  spoke_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_spoke" {
  source              = "./modules/vm"
  location            = local.location
  resource_group_name = local.spoke_resource_group_name
  nic_name            = local.spoke_nic_name

  vm_name = local.spoke_vm_name

  vm_image_offer               = local.spoke_vm_offer
  vm_image_publisher           = local.spoke_vm_publisher
  vm_image_sku                 = local.spoke_vm_sku
  vm_image_version             = local.spoke_vm_version
  vm_disk_caching              = local.spoke_vm_disk_caching
  vm_disk_storage_account_type = local.spoke_vm_disk_storage_account_type

  vm_size      = local.spoke_vm_size
  vm_subnet_id = module.spoke_vnet.sub-virtual_network_id//azurerm_subnet.spoke_vm_subnet.id

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on    = [module.spoke_vnet]
  managed_disks = toset([])
}

# Nsg of spoke.
locals {
  spoke_nsg_security_rules = {
    hub_subnet_mask     = local.hub_vnet_address,
    gateway_subnet_mask = local.hub_gateway_vpn_address_space[0]
  }
}

module "spoke_network_security_group" {
  source              = "./modules/nsg"
  security_group_name = "spoke_network_security_group"
  location            = local.location
  resource_group_name = local.spoke_resource_group_name
  security_rules      = jsondecode(templatefile("./network_security_rules/spoke.json", local.spoke_nsg_security_rules)).security_rules

  #  associated_subnet_id   = module.spoke_vnet.sub-virtual_network_id //azurerm_subnet.spoke_vm_subnet.id
  associated_subnets_ids = [module.spoke_vnet.sub-virtual_network_id]

  depends_on = [azurerm_resource_group.spoke_resource_group, module.spoke_vnet]
}

locals {
  map_spoke_routes = {
    fw_private_ip = module.hub_firewall.private_ip, hub_subnet_mask = local.hub_vnet_address,
  }
}

module "spoke_route_table" {
  source               = "./modules/route_table"
  associated_subnet_id = module.spoke_vnet.sub-virtual_network_id
  location             = local.location
  resource_group_name  = local.spoke_resource_group_name
  routes               = jsondecode(templatefile("./routes/spoke.json", local.map_spoke_routes)).routes
  route_table_name     = "spoke_route_table"

  depends_on = [module.spoke_vnet, module.hub_firewall]
}
