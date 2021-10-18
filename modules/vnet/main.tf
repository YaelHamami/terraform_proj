resource "azurerm_virtual_network" "virtual_network" {
  address_space       = var.virtual_network_address_space
  location            = var.location
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefixes

  depends_on = [azurerm_virtual_network.virtual_network]
}
#variable "subnets" {
#  type = list(object({
#    name = string,
#    address_prefixes = list(string)
#  }))
#}
#
#resource "azurerm_subnet" "subnet" {
#  for_each = toset(var.subnets)
#  name                 = each.value.name
#  resource_group_name  = var.resource_group_name
#  virtual_network_name = var.virtual_network_name
#  address_prefixes     = each.value.address_prefixes
#
#  depends_on = [azurerm_virtual_network.virtual_network]
#}