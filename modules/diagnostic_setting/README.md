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
| [azurerm_monitor_diagnostic_setting.firewall_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analytics_workspace_id"></a> [analytics\_workspace\_id](#input\_analytics\_workspace\_id) | The analytics workspace id. | `string` | n/a | yes |
| <a name="input_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#input\_diagnostic\_setting\_name) | The diagnostic setting name | `string` | n/a | yes |
| <a name="input_logs"></a> [logs](#input\_logs) | List of logs for the diagnostic setting. | <pre>list(object({<br>    category         = string,<br>    retention_policy = object({<br>      enabled = bool,<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | The id of the target resource that will be diagnose. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->