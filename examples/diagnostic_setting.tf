module "my_diagnostic_setting" {
  source                  = "../modules/diagnostic_setting"
  analytics_workspace_id  = azurerm_log_analytics_workspace.my_workspace.id
  diagnostic_setting_name = "my-diagnostic-setting"
  logs                    = [
    {
      "category" : "AzureFirewallNetworkRule",
      "retention_policy" : {
        "enabled" : true
      }
    }
  ]
  target_resource_id      = module.my_firewall.id
}
