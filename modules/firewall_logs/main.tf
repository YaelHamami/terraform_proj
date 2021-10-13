resource "azurerm_log_analytics_workspace" "fw_analytics_workspace" {
  location            = var.all_resources_location
  name                = var.analytics_workspace_name
  resource_group_name = var.rg_name
}

resource "azurerm_monitor_diagnostic_setting" "fw_diagnostic_setting" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.fw_analytics_workspace.id

  depends_on = [azurerm_log_analytics_workspace.fw_analytics_workspace]

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
