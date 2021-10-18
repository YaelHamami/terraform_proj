output "private_ip" {
  value = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

output "public_ip" {
  value = azurerm_public_ip.firewall_public_ip.ip_address
}

output "id" {
  value = azurerm_firewall.firewall.id
}

output "name" {
  value = azurerm_firewall.firewall.name
}

output "object" {
  value = azurerm_firewall.firewall
}