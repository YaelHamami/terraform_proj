output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "virtual_network" {
  value = azurerm_virtual_network.virtual_network
}

output "subnets_ids" {
  value = {for subnet in azurerm_subnet.subnets : subnet.name => subnet.id}
}

output "subnets" {
  value = azurerm_subnet.subnets
}
