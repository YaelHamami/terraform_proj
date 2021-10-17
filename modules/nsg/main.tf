# Nsg of spoke section.
resource "azurerm_network_security_group" "network_security_group" {
  name                = var.security_group_name//"spoke_subnet_security_group"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

  tags = {}
}

resource "azurerm_subnet_network_security_group_association" "spoke_nsg_association" {
  subnet_id                 = var.associated_subnet_id
  network_security_group_id = azurerm_network_security_group.network_security_group.id

  depends_on = [azurerm_network_security_group.network_security_group]
}

