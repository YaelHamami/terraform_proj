locals {
  firewall_policy_threat_intelligence_mode = "Deny"
}

# Firewall policy.
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  threat_intelligence_mode = local.firewall_policy_threat_intelligence_mode

  tags = {}
}
