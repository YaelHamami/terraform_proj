output "name" {
  value       = var.is_linux ? azurerm_linux_virtual_machine.vm[0].name : azurerm_windows_virtual_machine.vm[0].name
  description = "The vm name."
}

output "id" {
  value       = var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  description = "The vm id."

}

output "private_ip" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "The private ip."

}


