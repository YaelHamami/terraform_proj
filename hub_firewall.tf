#Workspace
locals {
  firewall_analytics_workspace_name = "firewall-analytics-workspace"
}

resource "azurerm_log_analytics_workspace" "firewall_analytics_workspace" {
  location            = local.location
  name                = local.firewall_analytics_workspace_name
  resource_group_name = local.hub_resource_group_name

  depends_on = [azurerm_resource_group.hub_resource_group]
}

#firewall
locals {
  priority_rule_collection        = 200
  map_firewall_network_rules_vars = {
    hub_subnet_mask     = local.hub_vnet_address,
    spoke_subnet_mask   = local.spoke_vnet_address,
    gateway_subnet_mask = local.hub_gateway_vpn_address_space
  }
}

locals {
  firewall_policy_name          = "hub-firewall-policy"
  firewall_public_ip_name       = "hub-firewall-public-ip"
  firewall_public_ip_sku        = "Standard"
  firewall_rule_collection_name = "allowTcp"
  firewall_name                 = "hub-firewall"
}

module "hub_firewall" {
  source = "./modules/firewall"

  location            = local.location
  resource_group_name = local.hub_resource_group_name
  subnet_id           = module.hub_vnet.subnets_ids["AzureFirewallSubnet"]

  firewall_policy_name = local.firewall_policy_name
  public_ip_name       = local.firewall_public_ip_name
  public_ip_sku        = local.firewall_public_ip_sku

  analytics_workspace_id = azurerm_log_analytics_workspace.firewall_analytics_workspace.id
  firewall_name          = local.firewall_name
  firewall_sku           = "Standard"
  rule_collection_groups =  local.rule_collection_groups

  depends_on = [
    azurerm_resource_group.hub_resource_group,
    module.hub_vnet,
    azurerm_log_analytics_workspace.firewall_analytics_workspace
  ]

}

locals {
  rule_collection_groups = {
    rule_collection_group = {
      name                         = local.firewall_rule_collection_name
      priority                     = local.priority_rule_collection
      network_rule_collections     = jsondecode(templatefile("./rule_collections/hub_firewall_network_rules.json", local.map_firewall_network_rules_vars)).network_rule_collections,
      application_rule_collections = jsondecode(file("./rule_collections/hub_firewall_application_rules.json")).application_rule_collections,
      nat_rule_collections         = jsondecode(file("./rule_collections/hub_firewall_nat_rules.json")).nat_rule_collections
    }
  }
}

output "rule_collection_groups" {
  value = { rule_collection = local.rule_collection_groups }
}