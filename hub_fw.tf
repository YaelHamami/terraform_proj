locals {
  priority_rule = 200
}

module "hub_firewall" {
  source = "./modules/firewall"

  all_resources_location  = local.all_resources_location
  firewall_policy_name    = "hub_firewall_policy"
  firewall_public_ip_name = "hub_firewall_public_ip"
  network_rules           = jsondecode(file("./rule_collections/hub_fw_network_rules.json")).rules
  rg_name                 = local.rg_name
  subnet_id               = azurerm_subnet.hub_AzureFirewallSubnet.id
  priority_rule           = local.priority_rule
  rule_name  = "allow_tcp"

  depends_on = [azurerm_resource_group.yael_proj_rg, azurerm_subnet.hub_AzureFirewallSubnet, azurerm_virtual_network.hub_vnet]
}

# Route table for the traffic between the hub and spoke will pass through the firewall.
resource "azurerm_route_table" "example" {
  name                          = "acceptanceTestSecurityGroup1"
  location                      = local.all_resources_location
  resource_group_name           = local.rg_name
  disable_bgp_route_propagation = false

  dynamic "route" {
    for_each = jsondecode(templatefile("./routes/hub_spoke_routes.json", {fw_private_ip = module.hub_firewall.fw_private_ip})).routes
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