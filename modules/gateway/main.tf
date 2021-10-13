locals {
  gw_public_ip_allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "gw_public_ip" {
  name                = var.gw_public_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method = local.gw_public_ip_allocation_method

  tags = {}
}

locals {
  gw_type = "Vpn"
  vpn_type = "RouteBased"
  gw_sku = "VpnGw1"
  gw_generation = "Generation1"
  ip_config_name = "vnetGatewayConfig${var.gw_name}"
  gw_private_ip_address_allocation = "Dynamic"
  vpn_client_protocols = ["OpenVPN"]
}

resource "azurerm_virtual_network_gateway" "gw" {
  name                = var.gw_name
  location            = var.location
  resource_group_name = var.rg_name

  type     = local.gw_type
  vpn_type = local.vpn_type

  active_active = false
  enable_bgp    = false
  sku           = local.gw_sku
  generation = local.gw_generation

  ip_configuration {
    name                          = local.ip_config_name
    public_ip_address_id          =  azurerm_public_ip.gw_public_ip.id
    private_ip_address_allocation = local.gw_private_ip_address_allocation
    subnet_id                     = var.gw_subnet_id
  }

  vpn_client_configuration {
    address_space = var.gw_vpn_address_space
    vpn_client_protocols = local.vpn_client_protocols

    aad_tenant = var.aad_tenant_gw
    aad_audience = var.aad_audience_gw
    aad_issuer = var.aad_issuer_gw
  }

  tags = {}
}