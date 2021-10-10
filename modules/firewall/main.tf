locals {
  gw_public_ip_allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.firewall_public_ip_name
  location            = var.all_resources_location
  resource_group_name = var.rg_name
  allocation_method = local.gw_public_ip_allocation_method
}

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.rg_name
  location            = var.all_resources_location //"West Europe"

  threat_intelligence_mode = "Deny"
}

resource "azurerm_firewall" "firewall" {
  name                = "testfirewall"
  location            = var.all_resources_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Allow"

  rule { // להפןך את זה לאוביייקט
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}