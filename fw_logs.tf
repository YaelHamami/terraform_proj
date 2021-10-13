locals {
  fw_analytics_workspace_name = "firewall-analytics-workspace"
  fw_diagnostic_setting_name  = "firewall_diagnostic_setting"
  map_logs_vars = {is_enabled = true}
}

module "hub_fw_diagnostic_setting" {
  source = "./modules/firewall_logs"

  all_resources_location   = local.all_resources_location
  analytics_workspace_name = local.fw_analytics_workspace_name
  diagnostic_setting_name  = local.fw_diagnostic_setting_name
  logs                     = jsondecode(templatefile("./diagnostic_setting_logs/fw_log.json", local.map_logs_vars)).logs
  rg_name                  = local.rg_name
  target_resource_id       = module.hub_firewall.fw_id

  depends_on = [azurerm_resource_group.yael_proj_rg]
#  depends_on = [module.hub_firewall]
}
