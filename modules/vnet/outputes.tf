output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "virtual_network" {
  value = azurerm_virtual_network.virtual_network
}

output "sub-virtual_network_id" {
  value = azurerm_subnet.subnet.id
}

output "sub-virtual_network_name" {
  value = azurerm_subnet.subnet.name
}

output "sub-virtual_network" {
  value = azurerm_subnet.subnet
}