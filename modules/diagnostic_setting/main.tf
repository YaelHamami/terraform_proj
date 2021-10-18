resource "azurerm_monitor_diagnostic_setting" "firewall_diagnostic_setting" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.analytics_workspace_id

  metric {
    category = "AllMetrics"
  }

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value.category

      retention_policy {
        enabled = log.value.retention_policy.enabled
      }
    }
  }
}
