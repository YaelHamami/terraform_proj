output "id" {
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.id
  description = "The diagnostic setting id."
}

output "name" {
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.name
  description = "The diagnostic setting name."
}

output "object" {
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting
  description = "The diagnostic setting object."
}