resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {}
}

# Linux VM.
resource "azurerm_linux_virtual_machine" "vm" {
  count = var.is_linux ? 1 : 0

  computer_name         = var.computer_name
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.size

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    name                 = "osdisk${var.vm_name}"
    caching              = var.disk_caching
    storage_account_type = var.disk_storage_account_type
  }

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  tags = {}

  depends_on = [azurerm_network_interface.nic]
}

# Windows vm.
resource "azurerm_windows_virtual_machine" "vm" {
  count = var.is_linux ? 0 : 1

  name                = var.vm_name
  computer_name       = var.computer_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = "osdisk${var.vm_name}"
    caching              = var.disk_caching
    storage_account_type = var.disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = {}

  depends_on = [azurerm_network_interface.nic]
}

resource "azurerm_managed_disk" "managed_data_disk" {
  count                = length(var.managed_data_disks)
  name                 = var.managed_data_disks[count.index].name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.managed_data_disks[count.index].storage_account_type
  create_option        = var.managed_data_disks[count.index].create_option
  disk_size_gb         = var.managed_data_disks[count.index].disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  count              = length(var.managed_data_disks)
  managed_disk_id    = azurerm_managed_disk.managed_data_disk[count.index].id
  virtual_machine_id = var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  lun                = var.managed_data_disks[count.index].lun
  caching            = var.managed_data_disks[count.index].caching

  depends_on = [azurerm_managed_disk.managed_data_disk, azurerm_linux_virtual_machine.vm]
}


