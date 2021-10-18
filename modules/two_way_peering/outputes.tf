output "peer_vnet1_to_vnet2_name" {
  value = azurerm_virtual_network_peering.peer_vnet1_to_vnet2.name
}

output "peer_vnet1_to_vnet2_id" {
  value = azurerm_virtual_network_peering.peer_vnet1_to_vnet2.id
}

output "peer_vnet1_to_vnet2_object" {
  value = azurerm_virtual_network_peering.peer_vnet1_to_vnet2
}

output "peer_vnet2_to_vnet1_name" {
  value = azurerm_virtual_network_peering.peer_vnet2_to_vnet1.name
}

output "peer_vnet2_to_vnet1_id" {
  value = azurerm_virtual_network_peering.peer_vnet2_to_vnet1.id
}

output "peer_vnet2_to_vnet1_object" {
  value = azurerm_virtual_network_peering.peer_vnet2_to_vnet1
}