# Firewall policy.
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  threat_intelligence_mode = "Deny"

  tags = {}
}

# Firewall Rules.
locals {
  rule_collection_groups     = defaults(var.rule_collection_groups,
  {
    nat_rule_collections = {
      action = "Dnat"
    }
  })
  rule_collection_group_name = "${azurerm_firewall_policy.firewall_policy.name}-rule-collection-group"
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_group_dynamic" {
  for_each           = local.rule_collection_groups
  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = each.value.priority

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collections
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = network_rule_collection.value.rules

        content {
          name                  = rule.value["name"]
          destination_ports     = rule.value["destination_ports"]
          source_addresses      = rule.value["source_addresses"]
          destination_addresses = rule.value["destination_addresses"]
          protocols             = rule.value["protocols"]
        }
      }
    }
  }

  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collections
    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name              = rule.value.name
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
          source_addresses  = rule.value.source_addresses
          destination_fqdns = rule.value.destination_fqdns
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = each.value.nat_rule_collections
    content {
      name     = nat_rule_collection.value.rule_collection_name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action
      rule {
        name                = nat_rule_collection.value.rule.name
        protocols           = nat_rule_collection.value.rule.protocols
        source_addresses    = nat_rule_collection.value.rule.source_addresses
        destination_address = nat_rule_collection.value.rule.destination_address
        destination_ports   = nat_rule_collection.value.rule.destination_ports
        translated_address  = nat_rule_collection.value.rule.translated_address
        translated_port     = nat_rule_collection.value.rule.translated_port
      }
    }
  }

  depends_on = [azurerm_firewall_policy.firewall_policy]
}
