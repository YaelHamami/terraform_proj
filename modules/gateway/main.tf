//TODO: לשנות לסטטי (אמור לעבוד)
locals {
  gateway_public_ip_allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "gateway_public_ip" {
  name                = var.gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = local.gateway_public_ip_allocation_method

  tags = {}
}

locals {
  gateway_type                          = "Vpn"
  vpn_type                              = "RouteBased"
  ip_config_name                        = "vnetGatewayConfig${var.gateway_name}"
  gateway_private_ip_address_allocation = "Dynamic"
  vpn_client_protocols                  = ["OpenVPN"]
}

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = local.gateway_type
  vpn_type = local.vpn_type

  active_active = false
  enable_bgp    = false
  sku           = var.gateway_sku
  generation    = var.gateway_generation

  ip_configuration {
    name                          = local.ip_config_name
    public_ip_address_id          = azurerm_public_ip.gateway_public_ip.id
    private_ip_address_allocation = local.gateway_private_ip_address_allocation
    subnet_id                     = var.gateway_subnet_id
  }

  vpn_client_configuration {
    address_space        = var.gateway_vpn_address_space
    vpn_client_protocols = local.vpn_client_protocols

    aad_tenant   = var.aad_tenant_gateway
    aad_audience = var.aad_audience_gateway
    aad_issuer   = var.aad_issuer_gateway
  }

  tags       = {}
  depends_on = [azurerm_public_ip.gateway_public_ip]
}