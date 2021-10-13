# Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gw_subnet_address = "10.0.2.0/24"
  hub_gw_subnet_name = "GatewaySubnet"
  hub_gw_name    = "hub-gw"
  hub_gw_public_ip_name = "hub-gw-public-ip"
  hub_gw_vpn_address_space = ["10.2.0.0/24"]
}

resource "azurerm_subnet" "gw_subnet" {
  name                 = local.hub_gw_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [local.hub_gw_subnet_address]
}

module "hub_gateway" {
  source = "./modules/gateway"

  location = local.all_resources_location
  rg_name = local.rg_name

  gw_name    = local.hub_gw_name
  gw_vpn_address_space = local.hub_gw_vpn_address_space
  gw_public_ip_name = local.hub_gw_public_ip_name

  aad_audience_gw = var.aad_audience_gw
  aad_issuer_gw = var.aad_issuer_gw
  aad_tenant_gw = var.aad_tenant_gw

  gw_subnet_id = azurerm_subnet.gw_subnet.id

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_subnet.gw_subnet]
}