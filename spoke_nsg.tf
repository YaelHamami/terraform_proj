## Nsg of spoke section.
#resource "azurerm_network_security_group" "spoke_nsg" {
#  name                = "Spoke_subnet_security_group"
#  location            = local.all_resources_location
#  resource_group_name = local.rg_name
#
#  security_rule {
#    name                       = "allow_TCP_in"
#    priority                   = 110
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#  security_rule {
#    name                       = "allow_ICMP_in"
#    priority                   = 115
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Icmp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#  security_rule {
#    name                       = "deny_all_in"
#    priority                   = 120
#    direction                  = "Inbound"
#    access                     = "Deny"
#    protocol                   = "*"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#  depends_on = [azurerm_resource_group.yael_proj_rg]
#}
#
#resource "azurerm_subnet_network_security_group_association" "spoke_nsg_association" {
#  subnet_id                 = azurerm_subnet.spoke_vm_subnet.id
#  network_security_group_id = azurerm_network_security_group.spoke_nsg.id
#
#  depends_on = [azurerm_subnet.spoke_vm_subnet, azurerm_network_security_group.spoke_nsg]
#}

module "spoke_nsg" {
  source = "./modules/nsg"
  all_resources_location = local.all_resources_location
  rg_name = local.rg_name
  security_rules = jsondecode(file("./network_security_rules/spoke_nsg_security_rules.json")).security_rules
  associated_subnet_id = azurerm_subnet.spoke_vm_subnet.id

  depends_on = [azurerm_resource_group.yael_proj_rg, azurerm_subnet.spoke_vm_subnet]
}