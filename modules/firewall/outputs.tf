data "azurerm_firewall" "fw_data" {
  name                = azurerm_firewall.firewall.name
  resource_group_name = var.rg_name
}

output "fw_private_ip" {
  value = data.azurerm_firewall.fw_data.ip_configuration[0].private_ip_address
}

output "fw_id" {
  value = azurerm_firewall.firewall.id
}