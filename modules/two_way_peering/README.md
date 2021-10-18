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
| [azurerm_virtual_network_peering.peer_vnet1_to_vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peer_vnet2_to_vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic_vnet1"></a> [allow\_forwarded\_traffic\_vnet1](#input\_allow\_forwarded\_traffic\_vnet1) | Controls if forwarded traffic from VMs in the remote virtual network is allowed for virtual network 1. | `bool` | n/a | yes |
| <a name="input_allow_forwarded_traffic_vnet2"></a> [allow\_forwarded\_traffic\_vnet2](#input\_allow\_forwarded\_traffic\_vnet2) | Controls if forwarded traffic from VMs in the remote virtual network is allowed for virtual network 2. | `bool` | n/a | yes |
| <a name="input_allow_gateway_transit_vnet1"></a> [allow\_gateway\_transit\_vnet1](#input\_allow\_gateway\_transit\_vnet1) | Controls gatewayLinks can be used in the remote virtual network’s link to the virtual network 1. | `bool` | n/a | yes |
| <a name="input_peer_vnet1_to_vnet2_name"></a> [peer\_vnet1\_to\_vnet2\_name](#input\_peer\_vnet1\_to\_vnet2\_name) | The name peering virtual network 1 to 2. | `string` | n/a | yes |
| <a name="input_peer_vnet2_to_vnet1_name"></a> [peer\_vnet2\_to\_vnet1\_name](#input\_peer\_vnet2\_to\_vnet1\_name) | The name peering virtual network 2 to 1. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_use_remote_gateways_vnet2"></a> [use\_remote\_gateways\_vnet2](#input\_use\_remote\_gateways\_vnet2) | Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow\_gateway\_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. | `bool` | n/a | yes |
| <a name="input_vnet1_id"></a> [vnet1\_id](#input\_vnet1\_id) | The id of other vnet to peer (2). | `string` | n/a | yes |
| <a name="input_vnet1_name"></a> [vnet1\_name](#input\_vnet1\_name) | The name of one vnet to peer (1). | `string` | n/a | yes |
| <a name="input_vnet2_id"></a> [vnet2\_id](#input\_vnet2\_id) | The id of other vnet to peer (1). | `string` | n/a | yes |
| <a name="input_vnet2_name"></a> [vnet2\_name](#input\_vnet2\_name) | The name of other vnet to peer (2). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_vnet1_to_vnet2_id"></a> [peer\_vnet1\_to\_vnet2\_id](#output\_peer\_vnet1\_to\_vnet2\_id) | n/a |
| <a name="output_peer_vnet1_to_vnet2_name"></a> [peer\_vnet1\_to\_vnet2\_name](#output\_peer\_vnet1\_to\_vnet2\_name) | n/a |
| <a name="output_peer_vnet1_to_vnet2_object"></a> [peer\_vnet1\_to\_vnet2\_object](#output\_peer\_vnet1\_to\_vnet2\_object) | n/a |
| <a name="output_peer_vnet2_to_vnet1_id"></a> [peer\_vnet2\_to\_vnet1\_id](#output\_peer\_vnet2\_to\_vnet1\_id) | n/a |
| <a name="output_peer_vnet2_to_vnet1_name"></a> [peer\_vnet2\_to\_vnet1\_name](#output\_peer\_vnet2\_to\_vnet1\_name) | n/a |
| <a name="output_peer_vnet2_to_vnet1_object"></a> [peer\_vnet2\_to\_vnet1\_object](#output\_peer\_vnet2\_to\_vnet1\_object) | n/a |
<!-- END_TF_DOCS -->