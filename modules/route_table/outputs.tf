output "name" {
  value       = azurerm_route_table.route_table.name
  description = "The route table name."
}

output "id" {
  value       = azurerm_route_table.route_table.id
  description = "The route table id."
}

output "object" {
  value       = azurerm_route_table.route_table
  description = "The route table object."
}