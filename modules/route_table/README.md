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
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_subnet_id"></a> [associated\_subnet\_id](#input\_associated\_subnet\_id) | The associated subnet. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The resource location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name. | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | The name of the route table. | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | The routes. | <pre>list(object({<br>    name                   = string,<br>    address_prefix         = string,<br>    next_hop_type          = string,<br>    next_hop_in_ip_address = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->