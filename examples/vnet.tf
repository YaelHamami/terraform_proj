module "my_vnet" {
  source                        = "../modules/vnet"
  location                      = "West Europe"
  resource_group_name           = "myResourceGroup"
  subnets                       = { subnet = { name = "mySubnet", address_prefixes = ["10.99.0.0/24"] } }
  address_space = ["10.99.0.0/16"]
  virtual_network_name          = module.my_vnet.virtual_network_name
}