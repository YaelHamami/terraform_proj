# Resource group section.
locals {
  common_resource_group_name = "proj_yael_rg"
  location                   = "West Europe"
}

resource "azurerm_resource_group" "common_resource_group" {
  name     = local.common_resource_group_name
  location = local.location

  tags = {}
}

# Peering the hub and spoke vnets.
resource "azurerm_virtual_network_peering" "peer_hub_to_spoke" {
  name                      = "peer_hub_to_spoke"
  resource_group_name       = azurerm_resource_group.hub_resource_group.name
  virtual_network_name      = module.hub_vnet.virtual_network_name
  remote_virtual_network_id = module.spoke_vnet.virtual_network_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true

  depends_on = [module.hub_vnet, module.spoke_vnet, module.hub_gateway]
}

resource "azurerm_virtual_network_peering" "peer_spoke_to_hub" {
  name                      = "peer_spoke_to_hub"
  resource_group_name       = azurerm_resource_group.spoke_resource_group.name
  virtual_network_name      = module.spoke_vnet.virtual_network_name
  remote_virtual_network_id = module.hub_vnet.virtual_network_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = true

  depends_on = [module.hub_vnet, module.spoke_vnet, module.hub_gateway]
}

