output "id" {
  value       = azurerm_virtual_network.virtual_network.id
  description = "The vnet id."
}

output "name" {
  value       = azurerm_virtual_network.virtual_network.name
  description = "The vnet name."
}

output "object" {
  value       = azurerm_virtual_network.virtual_network
  description = "The vnet object."
}

output "subnets_ids" {
  value       = {for subnet in azurerm_subnet.subnets : subnet.name => subnet.id}
  description = "The subnets ids."
}

output "subnets" {
  value       = azurerm_subnet.subnets
  description = "The subnets objects."
}
