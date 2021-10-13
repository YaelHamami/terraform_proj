
output "fw_private_ip" {
  value = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

output "fw_public_ip" {
  value = azurerm_public_ip.firewall_public_ip.ip_address
}

output "fw_id" {
  value = azurerm_firewall.firewall.id
}