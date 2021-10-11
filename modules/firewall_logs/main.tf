resource "azurerm_log_analytics_workspace" "fw_analytics_workspace" {
  location            = var.all_resources_location
  name                = var.analytics_workspace_name
  resource_group_name = var.rg_name
}

variable "logs" {
  type = list(
  object({
    category         = string
    retention_policy = object({
      enabled = bool
      days    = number
    })
  }))
  description = "List of logs for the diagnostic setting."
}

resource "azurerm_monitor_diagnostic_setting" "fw_diagnostic_setting" {
  name               = var.diagnostic_setting_name
  target_resource_id = var.target_resource_id // azurerm_firewall.firewall.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.fw_analytics_workspace.id

  dynamic "diagnostic_log" {
    for_each = var.logs
    content {
      category = diagnostic_log.value["category"]

    retention_policy = {
      enabled = diagnostic_log.value["enabled"]
      days = diagnostic_log.value["days"]
    }
#    category = "AzureFirewallNetworkRule"

#    retention_policy {
#      enabled = false
#      days = 7
    }

  }

  metric {
    category = "AllMetrics"
  }

  depends_on = [ azurerm_log_analytics_workspace.fw_analytics_workspace]
#  depends_on = [azurerm_firewall.firewall]
}
