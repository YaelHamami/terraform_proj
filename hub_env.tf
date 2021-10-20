# Resource group section.
locals {
  hub_resource_group_name = "proj-hub-resource-group"
  location                = "West Europe"
}
#
resource "azurerm_resource_group" "hub_resource_group" {
  name     = local.hub_resource_group_name
  location = local.location

  tags = {}
}

# Hub vnet section.
locals {
  hub_vnet_address           = "10.0.0.0/16"
  hub_vm_subnet_address      = "10.0.3.0/24"
  firewall_subnet_address    = "10.0.4.0/26"
  hub_gateway_subnet_address = "10.0.2.0/24"

  hub_vnet_name = "hub-vnet"
  hub_subnets   = {
    vm       = {
      name             = "HubVmSubnet",
      address_prefixes = [local.hub_vm_subnet_address]
    },
    firewall = {
      name             = "AzureFirewallSubnet",
      address_prefixes = [local.firewall_subnet_address]
    },
    gateway  = {
      name             = "GatewaySubnet",
      address_prefixes = [local.hub_gateway_subnet_address]
    }
  }
}

module "hub_vnet" {
  source               = "./modules/vnet"
  location             = local.location
  resource_group_name  = local.hub_resource_group_name
  address_space        = [local.hub_vnet_address]
  virtual_network_name = local.hub_vnet_name
  subnets              = local.hub_subnets

  depends_on = [azurerm_resource_group.hub_resource_group]
}

# Vm in the hub section.
locals {
  hub_vm_name                      = "hub-vm"
  hub_computer_name                = "hub-computer1"
  hub_vm_size                      = "Standard_B2s"
  hub_vm_publisher                 = "Canonical"
  hub_vm_offer                     = "UbuntuServer"
  hub_vm_sku                       = "16.04-LTS"
  hub_vm_version                   = "latest"
  hub_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_hub" {
  source              = "./modules/vm"
  location            = local.location
  resource_group_name = local.hub_resource_group_name

  vm_name                   = local.hub_vm_name
  computer_name             = local.hub_computer_name
  image_offer               = local.hub_vm_offer
  image_publisher           = local.hub_vm_publisher
  image_sku                 = local.hub_vm_sku
  image_version             = local.hub_vm_version
  disk_storage_account_type = local.hub_vm_disk_storage_account_type
  managed_data_disks        = jsondecode(file("./data_disks/example.json")).managed_data_disks

  size      = local.hub_vm_size
  subnet_id = module.hub_vnet.subnets_ids["HubVmSubnet"]

  admin_password = var.vm_password
  admin_username = var.vm_username

  depends_on = [module.hub_vnet]
}

#Hub nsg to vm subnet.
locals {
  hub_nsg_security_rules  = {
    spoke_subnet_mask = local.spoke_vnet_address,
  }
  hub_security_group_name = "hub-network-security-group"
}

module "hub_network_security_group" {
  source              = "./modules/nsg"
  security_group_name = local.hub_security_group_name
  location            = local.location

  associated_subnets_ids = [module.hub_vnet.subnets_ids["HubVmSubnet"]]

  resource_group_name = local.hub_resource_group_name
  security_rules      = jsondecode(templatefile("./network_security_rules/hub.json", local.hub_nsg_security_rules)).security_rules

  depends_on = [azurerm_resource_group.hub_resource_group, module.hub_vnet]
}

locals {
  map_hub_routes       = {
    firewall_private_ip = module.hub_firewall.private_ip, spoke_subnet_mask = local.spoke_vnet_address,
  }
  hub_route_table_name = "hub-route-table"
}

module "hub_route_table" {
  source                 = "./modules/route_table"
  location               = local.location
  resource_group_name    = local.hub_resource_group_name
  routes                 = jsondecode(templatefile("./routes/hub.json", local.map_hub_routes)).routes
  route_table_name       = local.hub_route_table_name
  associated_subnets_ids = { id = module.hub_vnet.subnets_ids["HubVmSubnet"] }

  depends_on = [module.hub_vnet, module.hub_firewall]
}

