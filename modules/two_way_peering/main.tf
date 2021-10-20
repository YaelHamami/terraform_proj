# Peering the hub and spoke vnets.
resource "azurerm_virtual_network_peering" "peer_vnet1_to_vnet2" {
  name                      = var.peer_vnet1_to_vnet2_name
  resource_group_name       = var.vnet1_resource_group_name
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic_vnet1
  allow_gateway_transit     = var.allow_gateway_transit_vnet1
}

resource "azurerm_virtual_network_peering" "peer_vnet2_to_vnet1" {
  name                      = var.peer_vnet2_to_vnet1_name
  resource_group_name       = var.vnet2_resource_group_name
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic_vnet2
  use_remote_gateways       = var.use_remote_gateways_vnet2
}