output "name" {
  value       = azurerm_network_security_group.network_security_group.name
  description = "The network security group name."
}

output "id" {
  value       = azurerm_network_security_group.network_security_group.id
  description = "The network security group id."
}

output "object" {
  value       = azurerm_network_security_group.network_security_group
  description = "The network security group object."
}