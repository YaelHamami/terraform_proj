output "name" {
  value       = azurerm_virtual_network_gateway.gateway.name
  description = "The gateway name."
}

output "id" {
  value       = azurerm_virtual_network_gateway.gateway.id
  description = "The gateway id."
}

output "object" {
  value       = azurerm_virtual_network_gateway.gateway
  description = "The gateway object."

}