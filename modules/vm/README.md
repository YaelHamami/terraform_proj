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
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.managed_data_disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password of the vm. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username of the vm. | `string` | n/a | yes |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | The computer name. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of rg and all the resources in the module. | `string` | n/a | yes |
| <a name="input_managed_data_disks"></a> [managed\_data\_disks](#input\_managed\_data\_disks) | n/a | <pre>list(object({<br>    name                 = string<br>    storage_account_type = string,<br>    create_option        = string,<br>    disk_size_gb         = string,<br>    lun                  = string,<br>    caching              = string<br>  }))</pre> | n/a | yes |
| <a name="input_nic_name"></a> [nic\_name](#input\_nic\_name) | Name of nic. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name. | `string` | n/a | yes |
| <a name="input_vm_disk_caching"></a> [vm\_disk\_caching](#input\_vm\_disk\_caching) | Caching of the disk vm. | `string` | n/a | yes |
| <a name="input_vm_disk_storage_account_type"></a> [vm\_disk\_storage\_account\_type](#input\_vm\_disk\_storage\_account\_type) | Type of the vm disk storage account. | `string` | n/a | yes |
| <a name="input_vm_image_offer"></a> [vm\_image\_offer](#input\_vm\_image\_offer) | The vm image offer. | `string` | n/a | yes |
| <a name="input_vm_image_publisher"></a> [vm\_image\_publisher](#input\_vm\_image\_publisher) | The vm image publisher. | `string` | n/a | yes |
| <a name="input_vm_image_sku"></a> [vm\_image\_sku](#input\_vm\_image\_sku) | The vm image sku. | `string` | n/a | yes |
| <a name="input_vm_image_version"></a> [vm\_image\_version](#input\_vm\_image\_version) | The vm image version. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of vm. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the vm. | `string` | n/a | yes |
| <a name="input_vm_subnet_id"></a> [vm\_subnet\_id](#input\_vm\_subnet\_id) | The id of the subnet the vm will be in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |
<!-- END_TF_DOCS -->