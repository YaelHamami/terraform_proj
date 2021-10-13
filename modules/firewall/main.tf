# Public IP of the firewall.
locals {
  firewall_public_ip_allocation_method = "Static"
  //"firewall_public_ip"
  firewall_sku                         = "Standard"
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.firewall_public_ip_name
  location            = var.all_resources_location
  resource_group_name = var.rg_name
  allocation_method   = local.firewall_public_ip_allocation_method
  sku                 = local.firewall_sku

  tags = {}
}

locals {
  fw_policy_threat_intelligence_mode = "Deny"
}

# Firewall policy.
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name //"firewall_hub_policy"
  resource_group_name = var.rg_name
  location            = var.all_resources_location //"West Europe"

  threat_intelligence_mode = local.fw_policy_threat_intelligence_mode

  tags = {}
}

# The firewall.
resource "azurerm_firewall" "firewall" {
  name                = "hub_firewall"
  location            = var.all_resources_location
  resource_group_name = var.rg_name
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  tags = {}

  depends_on = [azurerm_public_ip.firewall_public_ip, azurerm_firewall_policy.firewall_policy]
}

# Firewall Rules.
locals {
  rule_collection_action = "Allow"
  rule_collection_name   = "${azurerm_firewall.firewall.name}_rule_collection"
}
#resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
#  name                = local.rule_collection_name
#  azure_firewall_name = azurerm_firewall.firewall.name
#  resource_group_name = var.rg_name
#  priority            = var.priority_rule // 200
#  action              = local.rule_collection_action
#
#  dynamic "rule" {
#        for_each = var.network_rules
#
#        content {
#          name                  = rule.value["name"]
#          destination_ports     = rule.value["destination_ports"]
#          source_addresses      = rule.value["source_addresses"] // [ "10.0.0.0/16", ]
#          destination_addresses = rule.value["destination_addresses"] //["20.0.0.0/16",]
#          protocols             = rule.value["protocols"]
#        }
#
#  #      name                  = var.rule_name //"allow_tcp_toSpoke"
#  #      protocols             = var.list_rule_protocols // ["TCP",]
#  #      source_addresses      = var.list_source_addresses // [ "10.0.0.0/16", ]
#  #      destination_addresses = var.list_destination_addresses //["20.0.0.0/16",]
#  #      destination_ports     = var.list_destination_ports // ["22", ]
#
#    }
#
##  rule {
##    name = var.rule_name //"allow_tcp_toSpoke"
##
##    source_addresses = var.list_source_addresses
##    // [ "10.0.0.0/16", ]
##
##    destination_ports = var.list_destination_ports
##    // ["22", ]
##
##    destination_addresses = var.list_destination_addresses
##    //["20.0.0.0/16",]
##
##    protocols = var.list_rule_protocols
##    // ["TCP",]
##  }
#}

locals {
  network_rule_collection_priority = 200
}

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = local.rule_collection_name
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = var.priority_rule // 200

  network_rule_collection {
    name     = var.rule_name //"allow_tcp_toSpoke"
    priority = local.network_rule_collection_priority
    action   = local.rule_collection_action

    dynamic "rule" {
      for_each = var.network_rules

      content {
        name                  = rule.value["name"]
        destination_ports     = rule.value["destination_ports"]
        source_addresses      = rule.value["source_addresses"] // [ "10.0.0.0/16", ]
        destination_addresses = rule.value["destination_addresses"] //["20.0.0.0/16",]
        protocols             = rule.value["protocols"]
      }
    }
  }

  depends_on = [azurerm_firewall_policy.firewall_policy, azurerm_firewall.firewall]
}


