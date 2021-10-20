# The location var is for all resources in the project.
locals {
  spoke_resource_group_name = "proj-spoke-resource-group"
}

resource "azurerm_resource_group" "spoke_resource_group" {
  name     = local.spoke_resource_group_name
  location = local.location

  tags = {}
}

# Spoke vnet.
locals {
  spoke_vnet_name    = "spoke-vnet"
  spoke_vnet_address = "10.1.0.0/16"
  spoke_subnets      = {
    vm = {
      name             = "SpokeVmSubnet",
      address_prefixes = ["10.1.3.0/24"]
    }
  }
}

module "spoke_vnet" {
  source               = "./modules/vnet"
  location             = local.location
  resource_group_name  = local.spoke_resource_group_name
  address_space        = [local.spoke_vnet_address]
  virtual_network_name = local.spoke_vnet_name
  subnets              = local.spoke_subnets

  depends_on = [azurerm_resource_group.spoke_resource_group]
}

# Vm in the spoke section.
locals {
  spoke_vm_name                      = "spoke-vm"
  spoke_vm_size                      = "Standard_B2s"
  spoke_vm_publisher                 = "Canonical"
  spoke_vm_offer                     = "UbuntuServer"
  spoke_vm_sku                       = "16.04-LTS"
  spoke_vm_version                   = "latest"
  spoke_vm_disk_storage_account_type = "Standard_LRS"
  spoke_computer_name                = "spoke-computer1"
}

module "vm_of_spoke" {
  source              = "./modules/vm"
  location            = local.location
  resource_group_name = local.spoke_resource_group_name

  vm_name       = local.spoke_vm_name
  computer_name = local.spoke_computer_name

  image_offer               = local.spoke_vm_offer
  image_publisher           = local.spoke_vm_publisher
  image_sku                 = local.spoke_vm_sku
  image_version             = local.spoke_vm_version
  disk_storage_account_type = local.spoke_vm_disk_storage_account_type

  size      = local.spoke_vm_size
  subnet_id = module.spoke_vnet.subnets_ids["SpokeVmSubnet"]

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on = [module.spoke_vnet]
}

# Nsg of spoke.
locals {
  spoke_nsg_security_rules  = {
    hub_subnet_mask     = local.hub_vnet_address,
    gateway_subnet_mask = local.hub_gateway_vpn_address_space
  }
  spoke_security_group_name = "spoke-network-security-group"
}

module "spoke_network_security_group" {
  source                 = "./modules/nsg"
  security_group_name    = local.spoke_security_group_name
  location               = local.location
  resource_group_name    = local.spoke_resource_group_name
  security_rules         = jsondecode(templatefile("./network_security_rules/spoke.json", local.spoke_nsg_security_rules)).security_rules
  associated_subnets_ids = [module.spoke_vnet.subnets_ids["SpokeVmSubnet"]]

  depends_on = [azurerm_resource_group.spoke_resource_group, module.spoke_vnet]
}

locals {
  map_spoke_routes       = {
    firewall_private_ip = module.hub_firewall.private_ip, hub_subnet_mask = local.hub_vnet_address,
  }
  spoke_route_table_name = "spoke-route-table"
}

module "spoke_route_table" {
  source                 = "./modules/route_table"
  location               = local.location
  resource_group_name    = local.spoke_resource_group_name
  routes                 = jsondecode(templatefile("./routes/spoke.json", local.map_spoke_routes)).routes
  associated_subnets_ids = { id = module.spoke_vnet.subnets_ids["SpokeVmSubnet"] }
  route_table_name       = local.spoke_route_table_name

#  depends_on = [module.spoke_vnet, module.hub_firewall]
}

locals {
  peer_hub_to_spoke_name = "peer-hub-to-spoke"
  peer_spoke_to_hub_name = "peer-spoke-to-hub"
}

# 2 way peering hub and spoke.
module "tow_way_peering_hub_to_spoke" {
  source                        = "./modules/two_way_peering"
  vnet1_resource_group_name     = local.hub_resource_group_name
  vnet2_resource_group_name     = local.spoke_resource_group_name
  peer_vnet1_to_vnet2_name      = local.peer_hub_to_spoke_name
  vnet1_name                    = module.hub_vnet.name
  vnet2_id                      = module.spoke_vnet.id
  allow_forwarded_traffic_vnet1 = true
  allow_gateway_transit_vnet1   = true

  peer_vnet2_to_vnet1_name      = local.peer_spoke_to_hub_name
  vnet2_name                    = module.spoke_vnet.name
  vnet1_id                      = module.hub_vnet.id
  allow_forwarded_traffic_vnet2 = true
  use_remote_gateways_vnet2     = true

  depends_on = [module.hub_vnet, module.spoke_vnet, module.hub_gateway]
}
