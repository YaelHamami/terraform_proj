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
| [azurerm_firewall_policy.firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_group_dynamic](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collections"></a> [application\_rule\_collections](#input\_application\_rule\_collections) | List of the application rule collection. | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules    = list(object({<br>      name              = string,<br>      protocols         = list(object({<br>        type = string,<br>        port = number<br>      }))<br>      source_addresses  = list(string),<br>      destination_fqdns = list(string),<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | The firewall policy name. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | All resources location. | `string` | n/a | yes |
| <a name="input_nat_rule_collections"></a> [nat\_rule\_collections](#input\_nat\_rule\_collections) | List of the nat rule collection. | <pre>list(object({<br>    rule_collection_name = string<br>    priority             = number<br>    action               = string<br>    rule                 = object({<br>      name                = string<br>      protocols           = list(string)<br>      source_addresses    = list(string)<br>      destination_address = string<br>      destination_ports   = list(string)<br>      translated_address  = string<br>      translated_port     = string<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | List of the network rule collection. | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules    = list(object({<br>      name                  = string,<br>      source_addresses      = list(string),<br>      destination_ports     = list(string),<br>      destination_addresses = list(string),<br>      protocols             = list(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_priority_rule_collection_group"></a> [priority\_rule\_collection\_group](#input\_priority\_rule\_collection\_group) | The priority of the rule collection group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name. | `string` | n/a | yes |
| <a name="input_rule_collection_name"></a> [rule\_collection\_name](#input\_rule\_collection\_name) | The rule name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->