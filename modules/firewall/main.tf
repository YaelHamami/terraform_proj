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

#locals {
##  fw_policy_threat_intelligence_mode = "Deny"
#}

module "firewall_policy" {
  source               = "../firewall_policy"
  location             = var.location
  firewall_policy_name = var.firewall_policy_name
  resource_group_name  = var.resource_group_name
  application_rule_collections = var.application_rule_collections
  nat_rule_collections = var.nat_rule_collections
  network_rule_collections = var.network_rule_collections
  priority_rule_collection_group = var.priority_rule_collection_group
  rule_collection_name = var.rule_collection_name
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

# Firewall Rules.
#locals {
#  rule_collection_action     = "Allow"
#  rule_collection_group_name = "${azurerm_firewall.firewall.name}_rule_collection"
#}

#resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_group_dynamic" {
#  name               = local.rule_collection_group_name
#  firewall_policy_id = module.firewall_policy.id
#  priority           = var.priority_rule_collection_group
#
#  dynamic "network_rule_collection" {
#    for_each = var.network_rule_collections
#    content {
#      name     = network_rule_collection.value.name
#      priority = network_rule_collection.value.priority
#      action   = network_rule_collection.value.action
#
#      dynamic "rule" {
#        for_each = network_rule_collection.value.rules
#
#        content {
#          name                  = rule.value["name"]
#          destination_ports     = rule.value["destination_ports"]
#          source_addresses      = rule.value["source_addresses"]
#          destination_addresses = rule.value["destination_addresses"]
#          protocols             = rule.value["protocols"]
#        }
#      }
#    }
#  }
#
#  dynamic "application_rule_collection" {
#    for_each = var.application_rule_collections
#    content {
#      name     = application_rule_collection.value.name
#      priority = application_rule_collection.value.priority
#      action   = application_rule_collection.value.action
#      dynamic "rule" {
#        for_each = application_rule_collection.value.rules
#        content {
#          name              = rule.value.name
#          dynamic "protocols" {
#            for_each = rule.value.protocols
#            content {
#              type = protocols.value.type
#              port = protocols.value.port
#            }
#          }
#          source_addresses  = rule.value.source_addresses
#          destination_fqdns = rule.value.destination_fqdns
#        }
#      }
#    }
#  }
#
#  dynamic "nat_rule_collection" {
#    for_each = var.nat_rule_collections
#    content {
#      name     = nat_rule_collection.value.rule_collection_name
#      priority = nat_rule_collection.value.priority
#      action   = nat_rule_collection.value.action
#      rule {
#        name                = nat_rule_collection.value.rule.name
#        protocols           = nat_rule_collection.value.rule.protocols
#        source_addresses    = nat_rule_collection.value.rule.source_addresses
#        destination_address = nat_rule_collection.value.rule.destination_address
#        destination_ports   = nat_rule_collection.value.rule.destination_ports
#        translated_address  = nat_rule_collection.value.rule.translated_address
#        translated_port     = nat_rule_collection.value.rule.translated_port
#      }
#    }
#  }
#
#  depends_on = [module.firewall_policy]
#}

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


