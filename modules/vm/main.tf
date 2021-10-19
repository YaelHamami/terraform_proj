locals {
  nic_private_ip_address_allocation = "Dynamic"
  ip_configuration_name             = "testconfiguration1"
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = local.ip_configuration_name
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = local.nic_private_ip_address_allocation
  }

  tags = {}
}

locals {
  disk_name      = "osdisk${var.vm_name}"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

# Linux VM.
resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.is_linux ? 1 : 0

  computer_name         = var.computer_name
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size


  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  os_disk {
    name                 = local.disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_storage_account_type
  }

  admin_username                  = local.admin_username
  admin_password                  = local.admin_password
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
  size                = var.vm_size
  admin_username      = local.admin_username
  admin_password      = local.admin_password

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = local.disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_storage_account_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
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

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  count              = length(var.managed_data_disks)
  managed_disk_id    = azurerm_managed_disk.managed_data_disk[count.index].id
  virtual_machine_id = var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  lun                = var.managed_data_disks[count.index].lun
  caching            = var.managed_data_disks[count.index].caching

  depends_on = [azurerm_managed_disk.managed_data_disk, azurerm_linux_virtual_machine.vm]
}


