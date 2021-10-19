## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.80.0 |

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
| [azurerm_subnet.gateway_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/subnet) | resource |
| [azurerm_subnet.hubAzureFirewallSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.80.0/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience_gateway"></a> [aad\_audience\_gateway](#input\_aad\_audience\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_issuer_gateway"></a> [aad\_issuer\_gateway](#input\_aad\_issuer\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_aad_tenant_gateway"></a> [aad\_tenant\_gateway](#input\_aad\_tenant\_gateway) | Azure active directory tenant of the gateway. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id. | `string` | n/a | yes |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | Vm password for the admin. | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Vm username for the admin. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hub_firewall_id"></a> [hub\_firewall\_id](#output\_hub\_firewall\_id) | n/a |
㰊ⴡ‭䕂䥇彎䙔䑟䍏⁓ⴭਾਊ⌣唠慳敧ਊ恠桠汣洊摯汵⁥洢役湶瑥•ൻ 猠畯捲⁥†††††††††††㴠∠⸮洯摯汵獥瘯敮≴਍†潬慣楴湯†††††††††††‽圢獥⁴畅潲数ഢ 爠獥畯捲彥牧畯彰慮敭†††††㴠∠祭敒潳牵散片畯≰਍†畳湢瑥⁳†††††††††††‽⁻畳湢瑥㴠笠渠浡⁥‽洢卹扵敮≴‬摡牤獥彳牰晥硩獥㴠嬠ㄢ⸰㤹〮〮㈯∴⁝⁽ൽ 瘠物畴污湟瑥潷歲慟摤敲獳獟慰散㴠嬠ㄢ⸰㤹〮〮ㄯ∶൝ 瘠物畴污湟瑥潷歲湟浡⁥††††㴠洠摯汵⹥祭癟敮⹴楶瑲慵彬敮睴牯彫慮敭਍੽恠੠⌊‣湉異獴ਊ⁼慎敭簠䐠獥牣灩楴湯簠吠灹⁥⁼敄慦汵⁴⁼敒畱物摥簠簊ⴭⴭⴭ⵼ⴭⴭⴭⴭⴭⴭ⵼ⴭⴭ簭ⴭⴭⴭⴭ簭ⴺⴭⴭⴭ㨭੼⁼愼渠浡㵥椢灮瑵慟摡慟摵敩据彥慧整慷≹㰾愯‾慛摡彜畡楤湥散彜慧整慷嵹⌨湩異屴慟摡彜畡楤湥散彜慧整慷⥹簠䄠畺敲愠瑣癩⁥楤敲瑣牯⁹整慮瑮漠⁦桴⁥慧整慷⹹簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⁼愼渠浡㵥椢灮瑵慟摡楟獳敵彲慧整慷≹㰾愯‾慛摡彜獩畳牥彜慧整慷嵹⌨湩異屴慟摡彜獩畳牥彜慧整慷⥹簠䄠畺敲愠瑣癩⁥楤敲瑣牯⁹整慮瑮漠⁦桴⁥慧整慷⹹簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⁼愼渠浡㵥椢灮瑵慟摡瑟湥湡彴慧整慷≹㰾愯‾慛摡彜整慮瑮彜慧整慷嵹⌨湩異屴慟摡彜整慮瑮彜慧整慷⥹簠䄠畺敲愠瑣癩⁥楤敲瑣牯⁹整慮瑮漠⁦桴⁥慧整慷⹹簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⁼愼渠浡㵥椢灮瑵獟扵捳楲瑰潩彮摩㸢⼼㹡嬠畳獢牣灩楴湯彜摩⡝椣灮瑵彜畳獢牣灩楴湯彜摩 ⁼畓獢牣灩楴湯椠⹤簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⁼愼渠浡㵥椢灮瑵癟彭慰獳潷摲㸢⼼㹡嬠浶彜慰獳潷摲⡝椣灮瑵彜浶彜慰獳潷摲 ⁼浖瀠獡睳牯⁤潦⁲桴⁥摡業⹮簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⁼愼渠浡㵥椢灮瑵癟彭獵牥慮敭㸢⼼㹡嬠浶彜獵牥慮敭⡝椣灮瑵彜浶彜獵牥慮敭 ⁼浖甠敳湲浡⁥潦⁲桴⁥摡業⹮簠怠瑳楲杮⁠⁼⽮⁡⁼敹⁳੼⌊‣畏灴瑵ੳ簊丠浡⁥⁼敄捳楲瑰潩⁮੼⵼ⴭⴭ簭ⴭⴭⴭⴭⴭⴭ簭簊㰠⁡慮敭∽畯灴瑵桟扵晟物睥污彬摩㸢⼼㹡嬠畨屢晟物睥污屬楟嵤⌨畯灴瑵彜畨屢晟物睥污屬楟⥤簠渠愯簠㰊ⴡ‭久彄䙔䑟䍏⁓ⴭ�