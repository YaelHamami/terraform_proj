# Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gateway_subnet_address    = "10.0.2.0/24"
  hub_gateway_subnet_name       = "GatewaySubnet"
  hub_gateway_name              = "hub-gw"
  hub_gateway_public_ip_name    = "hub-gw-public-ip"
  hub_gateway_vpn_address_space = ["10.2.0.0/24"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = local.hub_gateway_subnet_name
  resource_group_name  = local.hub_resource_group_name
  virtual_network_name = module.hub_vnet.virtual_network_name
  address_prefixes     = [local.hub_gateway_subnet_address]

  depends_on = [module.hub_vnet]
}

module "hub_gateway" {
  source = "./modules/gateway"

  location            = local.location
  resource_group_name = local.hub_resource_group_name

  gateway_name              = local.hub_gateway_name
  gateway_vpn_address_space = local.hub_gateway_vpn_address_space
  gateway_public_ip_name    = local.hub_gateway_public_ip_name
  gateway_sku               = "VpnGw1"
  gateway_generation        = "Generation1"

  aad_audience_gateway = var.aad_audience_gateway
  aad_issuer_gateway   = var.aad_issuer_gateway
  aad_tenant_gateway   = var.aad_tenant_gateway

  gateway_subnet_id = azurerm_subnet.gateway_subnet.id

  depends_on = [azurerm_subnet.gateway_subnet]
}

locals {
  map_gateway_routes = {
    fw_private_ip = module.hub_firewall.private_ip, spoke_subnet_mask = local.spoke_vnet_address
  }
}

resource "azurerm_route_table" "gateway_route_table" {
  name                          = "gateway_route_table"
  location                      = local.location
  resource_group_name           = local.hub_resource_group_name
  disable_bgp_route_propagation = false

  dynamic "route" {
    for_each = jsondecode(templatefile("./routes/gateway.json", local.map_gateway_routes)).routes
    content {
      address_prefix         = route.value["address_prefix"]
      name                   = route.value["name"]
      next_hop_type          = route.value["next_hop_type"]
      next_hop_in_ip_address = route.value["next_hop_in_ip_address"]
    }
  }
  tags = {}
}