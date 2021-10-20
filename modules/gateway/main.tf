resource "azurerm_public_ip" "public_ip" {
  count               = var.is_active_active ? 2 : 1
  name                = var.public_ip_names[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = {}
}

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = var.is_active_active
  enable_bgp    = false
  sku           = var.sku
  generation    = var.generation

  dynamic "ip_configuration" {
    for_each = azurerm_public_ip.public_ip
    content {
      name                          = "vnetGatewayConfig${ip_configuration.value.name}"
      public_ip_address_id          = ip_configuration.value.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = var.subnet_id
    }
  }

  vpn_client_configuration {
    address_space        = var.vpn_address_space
    vpn_client_protocols = ["OpenVPN"]

    aad_tenant   = var.aad_tenant_gateway
    aad_audience = var.aad_audience_gateway
    aad_issuer   = var.aad_issuer_gateway
  }

  tags = {}

  depends_on = [azurerm_public_ip.public_ip]
}