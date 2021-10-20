resource "azurerm_route_table" "route_table" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false

  dynamic "route" {
    for_each = var.routes
    content {
      address_prefix         = route.value["address_prefix"]
      name                   = route.value["name"]
      next_hop_type          = route.value["next_hop_type"]
      next_hop_in_ip_address = route.value["next_hop_in_ip_address"]
    }
  }
  tags = {}
}

variable "associated_subnets_ids" {
  type = map(string)
  description = "Map of the subnet's ids to associate"
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = var.associated_subnets_ids
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = each.value

  depends_on = [azurerm_route_table.route_table]
}