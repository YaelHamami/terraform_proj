# Resource group section.
locals {
  rg_name = "yael_proj_rg"
  all_resources_location = "West Europe"
}

resource "azurerm_resource_group" "yael_proj_rg" {
  name     = local.rg_name
  location = local.all_resources_location

  tags = {}
}

# Peering the hub and spoke vnets.
resource "azurerm_virtual_network_peering" "peer_hub_to_spoke" {
  name                      = "peer_hub_to_spoke"
  resource_group_name       = azurerm_resource_group.yael_proj_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

resource "azurerm_virtual_network_peering" "peer_spoke_to_hub" {
  name                      = "peer_spoke_to_hub"
  resource_group_name       = azurerm_resource_group.yael_proj_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

# Route table for the traffic between the hub and spoke will pass through the firewall.
locals {
  map_routes_vars = {fw_private_ip = module.hub_firewall.fw_private_ip, hub_subnet_mask = local.hub_vnet_address, spoke_subnet_mask = local.spoke_vnet_address}
}
resource "azurerm_route_table" "example" {
  name                          = "acceptanceTestSecurityGroup1"
  location                      = local.all_resources_location
  resource_group_name           = local.rg_name
  disable_bgp_route_propagation = false

  dynamic "route" {
    for_each = jsondecode(templatefile("./routes/hub_spoke_routes.json", local.map_routes_vars)).routes
    content {
      address_prefix = route.value["address_prefix"]
      name           = route.value["name"]
      next_hop_type  = route.value["next_hop_type"]
      next_hop_in_ip_address = route.value["next_hop_in_ip_address"]
    }
  }
  tags = {}

#  depends_on = [module.hub_firewall]
}

resource "azurerm_subnet_route_table_association" "hub_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.hub_vm_subnet.id

  depends_on = [/*module.hub_firewall, */azurerm_route_table.example, azurerm_subnet.hub_vm_subnet]
}

resource "azurerm_subnet_route_table_association" "spoke_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.spoke_vm_subnet.id

  depends_on = [/*module.hub_firewall, */azurerm_route_table.example, azurerm_subnet.spoke_vm_subnet]
}
