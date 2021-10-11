# Public IP of the firewall.
locals {
  firewall_public_ip_allocation_method = "Static"
  firewall_public_ip_name = "firewall_public_ip"
  firewall_sku                 = "Standard"

}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = local.firewall_public_ip_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  allocation_method = local.firewall_public_ip_allocation_method
  sku                 = local.firewall_sku

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

locals {
  firewall_policy_name = "firewall_hub_policy"
}

# Firewall policy.
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = local.firewall_policy_name
  resource_group_name = local.rg_name
  location            = local.all_resources_location //"West Europe"

  threat_intelligence_mode = "Deny"

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

# The firewall.
resource "azurerm_firewall" "firewall" {
  name                = "hub_firewall"
  location            = local.all_resources_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  depends_on = [azurerm_public_ip.firewall_public_ip]
}

# Firewall Rules.
resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = local.rg_name
  priority            = 200
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      "20.0.0.0/16",
    ]

    protocols = [
      "TCP", "ICMP"
    ]
  }
}

# Route table for the traffic between the hub and spoke will pass through the firewall.
resource "azurerm_route_table" "example" {
  name                          = "acceptanceTestSecurityGroup1"
  location                      = local.all_resources_location
  resource_group_name           = local.rg_name
  disable_bgp_route_propagation = false

  route {
    name           = "hub_to_spoke"
    address_prefix = "10.0.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

    route {
    name           = "spoke_to_hub"
    address_prefix = "20.0.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

  depends_on = [azurerm_public_ip.firewall_public_ip]
}

resource "azurerm_subnet_route_table_association" "hub_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.hub_vm_subnet.id
}

resource "azurerm_subnet_route_table_association" "spoke_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.spoke_vm_subnet.id
}