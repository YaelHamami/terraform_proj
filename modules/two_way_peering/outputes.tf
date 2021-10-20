output "peer_vnet1_to_vnet2_name" {
  value       = azurerm_virtual_network_peering.peer_vnet1_to_vnet2.name
  description = "The peer host vnet to remote vnet name."
}

output "peer_vnet1_to_vnet2_id" {
  value       = azurerm_virtual_network_peering.peer_vnet1_to_vnet2.id
  description = "The peer host vnet to remote vnet id."
}

output "peer_vnet1_to_vnet2_object" {
  value       = azurerm_virtual_network_peering.peer_vnet1_to_vnet2
  description = "The peer host vnet to remote vnet object."
}

output "peer_vnet2_to_vnet1_name" {
  value       = azurerm_virtual_network_peering.peer_vnet2_to_vnet1.name
  description = "The peer remote vnet to host vnet name."
}

output "peer_vnet2_to_vnet1_id" {
  value       = azurerm_virtual_network_peering.peer_vnet2_to_vnet1.id
  description = "The peer remote vnet to host vnet id."
}

output "peer_vnet2_to_vnet1_object" {
  value       = azurerm_virtual_network_peering.peer_vnet2_to_vnet1
  description = "The peer remote vnet to host vnet object."
}