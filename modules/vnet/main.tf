resource "azurerm_virtual_network" "virtual_network" {
  address_space       = var.address_space
  location            = var.location
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  depends_on = [azurerm_virtual_network.virtual_network]
}