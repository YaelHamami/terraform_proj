resource "azurerm_virtual_network" "vnet" {
  name                = var.hub_vnet_name
  location            = var.all_resources_location
  resource_group_name = var.rg_name
  address_space       = [var.hub_vnet_address]
}
