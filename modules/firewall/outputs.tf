output "private_ip" {
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  description = "The private ip object."
}

output "public_ip" {
  value       = azurerm_public_ip.firewall_public_ip.ip_address
  description = "The public ip object"
}

output "id" {
  value       = azurerm_firewall.firewall.id
  description = "The firewall id"
}

output "name" {
  value       = azurerm_firewall.firewall.name
  description = "The firewall name"
}

output "object" {
  value       = azurerm_firewall.firewall
  description = "The firewall object"
}