#locals {
#  diagnostic_setting_name = "${azurerm_firewall.firewall.name}_diagnostic_setting"
#  analytics_workspace_name = "hub-firewall-workspace"
#}
#
#resource "azurerm_log_analytics_workspace" "fw_analytics_workspace" {
#  location            = local.all_resources_location
#  name                = local.analytics_workspace_name
#  resource_group_name = local.rg_name
#}
#
#resource "azurerm_monitor_diagnostic_setting" "fw_diagnostic_setting" {
#  name               = local.diagnostic_setting_name
#  target_resource_id = azurerm_firewall.firewall.id
#
#  log_analytics_workspace_id = azurerm_log_analytics_workspace.fw_analytics_workspace.id
#
#  log {
#    category = "AzureFirewallNetworkRule"
#
#    retention_policy {
#      enabled = false
#      days = 7
#    }
#  }
#
#  metric {
#    category = "AllMetrics"
#  }
#
#  depends_on = [azurerm_firewall.firewall, azurerm_log_analytics_workspace.fw_analytics_workspace]
#}

module "hub_fw_diagnostic_setting" {
  source = "./modules/firewall_logs"

  all_resources_location   = local.all_resources_location
  analytics_workspace_name = "firewall-analytics-workspace"
  diagnostic_setting_name  = "firewall_diagnostic_setting"
  logs                     = jsondecode(file("./diagnostic_setting_logs/fw_log.json")).logs
  rg_name                  = local.rg_name
  target_resource_id       = module.hub_firewall.fw_id

  depends_on = [module.hub_firewall]
}
