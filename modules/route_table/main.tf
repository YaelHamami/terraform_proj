resource "azurerm_route_table" "route_table" {
  name                          = var.route_table_name //"acceptanceTestSecurityGroup1"
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

resource "azurerm_subnet_route_table_association" "route_table_association" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = var.associated_subnet_id

  depends_on = [azurerm_route_table.route_table]
}