# Public IP of the firewall.
locals {
  firewall_public_ip_allocation_method = "Static"
  firewall_sku                         = "Standard"
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = local.firewall_public_ip_allocation_method
  sku                 = var.public_ip_sku

  tags = {}
}

module "firewall_policy" {
  source                         = "../firewall_policy"
  location                       = var.location
  firewall_policy_name           = var.firewall_policy_name
  resource_group_name            = var.resource_group_name
  application_rule_collections   = var.application_rule_collections
  nat_rule_collections           = var.nat_rule_collections
  network_rule_collections       = var.network_rule_collections
  priority_rule_collection_group = var.priority_rule_collection_group
  rule_collection_name           = var.rule_collection_name
}

# The firewall.
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = module.firewall_policy.id

  ip_configuration {
    name                 = "ip_configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  tags = {}

  depends_on = [azurerm_public_ip.firewall_public_ip, module.firewall_policy]
}

locals {
  fw_diagnostic_setting_name = "firewall_diagnostic_setting"
  map_logs_vars              = { is_enabled = true }
}

module "hub_firewall_diagnostic_setting" {
  source                  = "../diagnostic_setting"
  analytics_workspace_id  = var.analytics_workspace_id
  diagnostic_setting_name = local.fw_diagnostic_setting_name
  logs                    = [
    {
      "category" : "AzureFirewallNetworkRule",
      "retention_policy" : {
        "enabled" : true
      }
    },
    {
      "category" : "AzureFirewallApplicationRule",
      "retention_policy" : {
        "enabled" : true
      }
    },
    {
      "category" : "AzureFirewallDnsProxy",
      "retention_policy" : {
        "enabled" : true
      }
    }
  ]
  target_resource_id      = azurerm_firewall.firewall.id

  depends_on = [azurerm_firewall.firewall]
}


