output "name" {
  value       = azurerm_firewall_policy.firewall_policy.name
  description = "The firewall policy name."
}

output "id" {
  value       = azurerm_firewall_policy.firewall_policy.id
  description = "The firewall id."
}

output "object" {
  value       = azurerm_firewall_policy.firewall_policy
  description = "The firewall policy object."
}