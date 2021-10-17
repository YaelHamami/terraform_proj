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

# Route table for the traffic between the hub and spoke will pass through the firewall.
#locals {
#  map_routes_vars = {
#    fw_private_ip     = module.hub_firewall.fw_private_ip, hub_subnet_mask = local.hub_vnet_address,
#    spoke_subnet_mask = local.spoke_vnet_address, vpn_private_ip = "10.2.0.2"
#  }
#}
#resource "azurerm_route_table" "example" {
#  name                          = "acceptanceTestSecurityGroup1"
#  location                      = local.all_resources_location
#  resource_group_name           = local.rg_name
#  disable_bgp_route_propagation = false
#
#  dynamic "route" {
#    for_each = jsondecode(templatefile("./routes/hub_spoke_routes.json", local.map_routes_vars)).routes
#    content {
#      address_prefix         = route.value["address_prefix"]
#      name                   = route.value["name"]
#      next_hop_type          = route.value["next_hop_type"]
#      next_hop_in_ip_address = route.value["next_hop_in_ip_address"]
#    }
#  }
#  tags = {}
#
#  #  depends_on = [module.hub_firewall]
#
#}
#
#resource "azurerm_subnet_route_table_association" "hub_route_table_association_to_hub" {
#  route_table_id = azurerm_route_table.example.id
#  subnet_id      = azurerm_subnet.hub_vm_subnet.id
#
#  depends_on = [/*module.hub_firewall, */azurerm_route_table.example, azurerm_subnet.hub_vm_subnet]
#}
#
#resource "azurerm_subnet_route_table_association" "spoke_route_table_association_to_spoke" {
#  route_table_id = azurerm_route_table.example.id
#  subnet_id      = azurerm_subnet.spoke_vm_subnet.id
#
#  depends_on = [/*module.hub_firewall, */azurerm_route_table.example, azurerm_subnet.spoke_vm_subnet]
#}
#
#resource "azurerm_subnet_route_table_association" "spoke_route_table_association_to_gateway" {
#  route_table_id = azurerm_route_table.example.id
#  subnet_id      = azurerm_subnet.gw_subnet.id
#
#  depends_on = [/*module.hub_firewall, */azurerm_route_table.example, azurerm_subnet.gw_subnet]
#}


#module "gateway_route_table" {
#  source               = "./modules/route_table"
#  associated_subnet_id = azurerm_subnet.gateway_subnet.id
#  location             = local.location
#  resource_group_name              = local.resource_group_name
#  routes               = jsondecode(templatefile("./routes/gateway.json", local.map_gateway_routes)).routes
#  route_table_name = "gateway_route_table"
#
#  depends_on = [azurerm_subnet.gateway_subnet, module.hub_firewall]
#}

