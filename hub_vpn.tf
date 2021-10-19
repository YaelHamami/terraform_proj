# Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gateway_subnet_address    = "10.0.2.0/24"
  hub_gateway_subnet_name       = "GatewaySubnet"
  hub_gateway_name              = "hub-gw"
  hub_gateway_public_ip_name    = "hub-gw-public-ip"
  hub_gateway_vpn_address_space = "10.2.0.0/24"
}

locals {
  gateway_sku        = "VpnGw1"
  gateway_generation = "Generation1"
}

module "hub_gateway" {
  source = "./modules/gateway"

  location            = local.location
  resource_group_name = local.hub_resource_group_name

  gateway_name              = local.hub_gateway_name
  gateway_vpn_address_space = [local.hub_gateway_vpn_address_space]
  gateway_public_ip_name    = local.hub_gateway_public_ip_name
  gateway_sku               = local.gateway_sku
  gateway_generation        = local.gateway_generation

  aad_audience_gateway = var.aad_audience_gateway
  aad_issuer_gateway   = var.aad_issuer_gateway
  aad_tenant_gateway   = var.aad_tenant_gateway

  gateway_subnet_id = module.hub_vnet.subnets_ids["GatewaySubnet"]

  depends_on = [module.hub_vnet]
}