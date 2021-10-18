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
| [azurerm_network_security_group.network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_subnets_ids"></a> [associated\_subnets\_ids](#input\_associated\_subnets\_ids) | list of ids to associate with the network security group. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of rg and all the resources in the module. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name. | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The nam eof the network security group. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | List of the ids of subnets in which the nsg will associate with. | <pre>list(object({<br>    name                       = string,<br>    priority                   = number,<br>    direction                  = string,<br>    access                     = string,<br>    protocol                   = string,<br>    //source_port_range          = optional(string),<br>    source_port_ranges         = list(string),<br>    //destination_port_range     = optional(string),<br>    destination_port_ranges    = list(string),<br>    source_address_prefix      = string,<br>    destination_address_prefix = string,<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->