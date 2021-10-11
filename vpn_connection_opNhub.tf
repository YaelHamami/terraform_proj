# Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gw_subnet_address = "10.0.2.0/24"
  hub_gw_subnet_name = "GatewaySubnet"
  hub_gw_name    = "hub-gw"
  hub_gw_public_ip_name = "hub-gw-public-ip"
  hub_gw_vpn_address_space = ["10.2.0.0/24"]
}

module "gw_with_subnet" {
  source = "./modules/gw_with_subnet"

  location = local.all_resources_location
  rg_name = local.rg_name

  vnet_name = azurerm_virtual_network.hub_vnet.name

  gw_subnet_address = local.hub_gw_subnet_address
  gw_subnet_name = local.hub_gw_subnet_name

  gw_name    = local.hub_gw_name
  gw_vpn_address_space = local.hub_gw_vpn_address_space
  gw_public_ip_name = local.hub_gw_public_ip_name

  aad_audience_gw = var.aad_audience_gw
  aad_issuer_gw = var.aad_issuer_gw
  aad_tenant_gw = var.aad_tenant_gw

  depends_on = [azurerm_virtual_network.hub_vnet]
}