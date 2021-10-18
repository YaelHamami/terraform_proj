<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.gateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience_gateway"></a> [aad\_audience\_gateway](#input\_aad\_audience\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_issuer_gateway"></a> [aad\_issuer\_gateway](#input\_aad\_issuer\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_tenant_gateway"></a> [aad\_tenant\_gateway](#input\_aad\_tenant\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_gateway_generation"></a> [gateway\_generation](#input\_gateway\_generation) | The gateway generation. | `string` | n/a | yes |
| <a name="input_gateway_name"></a> [gateway\_name](#input\_gateway\_name) | Name of gateway. | `string` | n/a | yes |
| <a name="input_gateway_public_ip_name"></a> [gateway\_public\_ip\_name](#input\_gateway\_public\_ip\_name) | Name of public ip of the gateway. | `string` | n/a | yes |
| <a name="input_gateway_sku"></a> [gateway\_sku](#input\_gateway\_sku) | The gateway sku. | `string` | n/a | yes |
| <a name="input_gateway_subnet_id"></a> [gateway\_subnet\_id](#input\_gateway\_subnet\_id) | The id of the gateway subnet. | `string` | n/a | yes |
| <a name="input_gateway_vpn_address_space"></a> [gateway\_vpn\_address\_space](#input\_gateway\_vpn\_address\_space) | Address Space of VPN gateway client. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of rg and all the resources in the module. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of rg. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->