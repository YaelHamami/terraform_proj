module "my_vm" {
  source                       = "../modules/vm"
  admin_password               = "passsword1234!"
  admin_username               = "testUser"
  computer_name                = "myComp"
  location                     = "West Europe"
  nic_name                     = "myNic"
  resource_group_name          = "myResourceGroup"
  disk_caching              = "ReadWrite"
  disk_storage_account_type = "Standard_LRS"
  image_offer               = "UbuntuServer"
  image_publisher           = "Canonical"
  image_sku                 = "16.04-LTS"
  image_version             = "latest"
  vm_name                      = "myVm"
  size                      = "Standard_B2s"
  subnet_id                 = module.my_vnet.subnets_ids["vmSubnet"]
  managed_data_disks           = [
    {
      "name" : "first_disk",
      "storage_account_type" : "Standard_LRS",
      "create_option" : "Empty",
      "disk_size_gb" : 10,
      "lun" : "10",
      "caching" : "ReadWrite"
    },
    {
      "name" : "second_disk",
      "storage_account_type" : "Standard_LRS",
      "create_option" : "Empty",
      "disk_size_gb" : 20,
      "lun" : "20",
      "caching" : "ReadOnly"
    }
  ]
  is_linux                     = true
}
