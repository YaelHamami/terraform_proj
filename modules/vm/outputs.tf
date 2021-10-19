output "name" {
  value =  var.is_linux ? azurerm_linux_virtual_machine.vm[0].name : azurerm_windows_virtual_machine.vm[0].name
}

output "id" {
  value =  var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
}

output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}


