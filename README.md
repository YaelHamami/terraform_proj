## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.80.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience_gateway"></a> [aad\_audience\_gateway](#input\_aad\_audience\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_issuer_gateway"></a> [aad\_issuer\_gateway](#input\_aad\_issuer\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_tenant_gateway"></a> [aad\_tenant\_gateway](#input\_aad\_tenant\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id. | `string` | n/a | yes |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | Vm password for the admin. | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Vm username for the admin. | `string` | n/a | yes |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hub_firewall"></a> [hub\_firewall](#module\_hub\_firewall) | ./modules/firewall | n/a |
| <a name="module_hub_gateway"></a> [hub\_gateway](#module\_hub\_gateway) | ./modules/gateway | n/a |
| <a name="module_hub_network_security_group"></a> [hub\_network\_security\_group](#module\_hub\_network\_security\_group) | ./modules/nsg | n/a |
| <a name="module_hub_route_table"></a> [hub\_route\_table](#module\_hub\_route\_table) | ./modules/route_table | n/a |
| <a name="module_hub_vnet"></a> [hub\_vnet](#module\_hub\_vnet) | ./modules/vnet | n/a |
| <a name="module_spoke_network_security_group"></a> [spoke\_network\_security\_group](#module\_spoke\_network\_security\_group) | ./modules/nsg | n/a |
| <a name="module_spoke_route_table"></a> [spoke\_route\_table](#module\_spoke\_route\_table) | ./modules/route_table | n/a |
| <a name="module_spoke_vnet"></a> [spoke\_vnet](#module\_spoke\_vnet) | ./modules/vnet | n/a |
| <a name="module_tow_way_peering_hub_to_spoke"></a> [tow\_way\_peering\_hub\_to\_spoke](#module\_tow\_way\_peering\_hub\_to\_spoke) | ./modules/two_way_peering | n/a |
| <a name="module_vm_of_hub"></a> [vm\_of\_hub](#module\_vm\_of\_hub) | ./modules/vm | n/a |
| <a name="module_vm_of_spoke"></a> [vm\_of\_spoke](#module\_vm\_of\_spoke) | ./modules/vm | n/a |
## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.firewall_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.hub_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/resource_group) | resource |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rule_collection_groups"></a> [rule\_collection\_groups](#output\_rule\_collection\_groups) | n/a |
