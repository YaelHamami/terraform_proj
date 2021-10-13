locals {
  nic_private_ip_address_allocation = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name
  enable_ip_forwarding = var.enable_ip_forwarding

  ip_configuration {
    name                          = local.id_conf_name
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = local.nic_private_ip_address_allocation
  }

  tags = {}
}

locals {
  id_conf_name = "testconfiguration1"
  disk_name ="osdisk${var.vm_name}"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

resource "azurerm_linux_virtual_machine" "vm" {
  computer_name         = var.vm_name
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
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


