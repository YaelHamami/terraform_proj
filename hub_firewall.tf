# Firewall subnet.
locals {
  firewall_subnet_name    = "AzureFirewallSubnet"
  firewall_subnet_address = "10.0.4.0/26"
}
resource "azurerm_subnet" "hub_AzureFirewallSubnet" {
  name                 = local.firewall_subnet_name
  resource_group_name  = local.hub_resource_group_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.firewall_subnet_address]

  depends_on = [module.hub_vnet]
}

#Workspace
locals {
  firewall_analytics_workspace_name = "firewall-analytics-workspace"
  #  fw_diagnostic_setting_name  = "firewall_diagnostic_setting"
  #  map_logs_vars               = { is_enabled = true }
}

resource "azurerm_log_analytics_workspace" "firewall_analytics_workspace" {
  location            = local.location
  name                = local.firewall_analytics_workspace_name
  resource_group_name = local.hub_resource_group_name

  depends_on = [azurerm_resource_group.hub_resource_group]
}

#firewall
locals {
  priority_rule                   = 200
  map_firewall_network_rules_vars = {
    hub_subnet_mask     = local.hub_vnet_address,
    spoke_subnet_mask   = local.spoke_vnet_address,
    gateway_subnet_mask = local.hub_gateway_vpn_address_space[0]
  }
}

module "hub_firewall" {
  source = "./modules/firewall"

  location                  = local.location
  firewall_policy_name      = "hub_firewall_policy"
  firewall_public_ip_name   = "hub_firewall_public_ip"
  public_ip_sku             = "Standard"
  network_rules             = jsondecode(templatefile("./rule_collections/hub_fw_network_rules.json", local.map_firewall_network_rules_vars)).rules
  resource_group_name       = local.hub_resource_group_name
  subnet_id                 = azurerm_subnet.hub_AzureFirewallSubnet.id
  priority_rule             = local.priority_rule
  rule_collection_name      = "allow_tcp"
  fw_analytics_workspace_id = azurerm_log_analytics_workspace.firewall_analytics_workspace.id

  depends_on = [
    azurerm_resource_group.hub_resource_group,
    azurerm_subnet.hub_AzureFirewallSubnet,
    azurerm_log_analytics_workspace.firewall_analytics_workspace
  ]

}

#module "hub_fw_diagnostic_setting" {
#  source                  = "./modules/diagnostic_setting"
#  analytics_workspace_id  = azurerm_log_analytics_workspace.fw_analytics_workspace.id
#  diagnostic_setting_name = local.fw_diagnostic_setting_name
#  logs                    = jsondecode(templatefile("./diagnostic_settings/firewall.json", local.map_logs_vars)).logs
#  target_resource_id      = module.hub_firewall.fw_id
#
#  depends_on = [azurerm_resource_group.yael_proj_rg, azurerm_log_analytics_workspace.fw_analytics_workspace]
#  #  depends_on = [module.hub_firewall]
#}