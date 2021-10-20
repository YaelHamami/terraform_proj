module "my_gateway" {
  source                    = "../modules/gateway"
  aad_tenant_gateway        = "https://login.microsoftonline.com/c998986356bf6-8e932f60bf2b/"
  aad_audience_gateway      = "41b543e61-6c1e-4655-b897-cd054e0ed4b4"
  aad_issuer_gateway        = "https://sts.windows.net/c9ad96875456sfbf6-8e932f60bf2b/"
  generation        = "Generation1"
  name              = "myGateway"
  public_ip_name    = "gatewayPublicIp"
  sku               = "VpnGw1"
  subnet_id         = module.my_vnet.subnets_ids["gatewaySubnet"]
  vpn_address_space = ["10.6.0.0/24"]
  location                  = "West Europe"
  resource_group_name       = "myResourceGroup"
}