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
㰊ⴡ‭䕂䥇彎䙔䑟䍏⁓ⴭਾ⌣删煥極敲敭瑮ੳ簊丠浡⁥⁼敖獲潩⁮੼⵼ⴭⴭ簭ⴭⴭⴭⴭ簭簊㰠⁡慮敭∽敲畱物浥湥彴穡牵牥≭㰾愯‾慛畺敲浲⡝爣煥極敲敭瑮彜穡牵牥⥭簠㴠⸲〸〮簠ਊ⌣倠潲楶敤獲ਊ⁼慎敭簠嘠牥楳湯簠簊ⴭⴭⴭ⵼ⴭⴭⴭⴭ੼⁼愼渠浡㵥瀢潲楶敤彲穡牵牥≭㰾愯‾慛畺敲浲⡝瀣潲楶敤屲慟畺敲浲 ⁼⸲〸〮簠ਊ⌣䴠摯汵獥ਊ⁼慎敭簠匠畯捲⁥⁼敖獲潩⁮੼⵼ⴭⴭ簭ⴭⴭⴭⴭ⵼ⴭⴭⴭⴭ੼⁼愼渠浡㵥洢摯汵彥畨形楦敲慷汬㸢⼼㹡嬠畨屢晟物睥污嵬⌨潭畤敬彜畨屢晟物睥污⥬簠⸠洯摯汵獥是物睥污⁬⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥畨形慧整慷≹㰾愯‾桛扵彜慧整慷嵹⌨潭畤敬彜畨屢束瑡睥祡 ⁼⼮潭畤敬⽳慧整慷⁹⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥畨形敮睴牯彫敳畣楲祴束潲灵㸢⼼㹡嬠畨屢湟瑥潷歲彜敳畣楲祴彜牧畯嵰⌨潭畤敬彜畨屢湟瑥潷歲彜敳畣楲祴彜牧畯⥰簠⸠洯摯汵獥港杳簠渠愯簠簊㰠⁡慮敭∽潭畤敬桟扵牟畯整瑟扡敬㸢⼼㹡嬠畨屢牟畯整彜慴汢嵥⌨潭畤敬彜畨屢牟畯整彜慴汢⥥簠⸠洯摯汵獥爯畯整瑟扡敬簠渠愯簠簊㰠⁡慮敭∽潭畤敬桟扵癟敮≴㰾愯‾桛扵彜湶瑥⡝洣摯汵履桟扵彜湶瑥 ⁼⼮潭畤敬⽳湶瑥簠渠愯簠簊㰠⁡慮敭∽潭畤敬獟潰敫湟瑥潷歲獟捥牵瑩役牧畯≰㰾愯‾獛潰敫彜敮睴牯屫獟捥牵瑩屹束潲灵⡝洣摯汵履獟潰敫彜敮睴牯屫獟捥牵瑩屹束潲灵 ⁼⼮潭畤敬⽳獮⁧⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥灳歯彥潲瑵彥慴汢≥㰾愯‾獛潰敫彜潲瑵履瑟扡敬⡝洣摯汵履獟潰敫彜潲瑵履瑟扡敬 ⁼⼮潭畤敬⽳潲瑵彥慴汢⁥⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥灳歯彥湶瑥㸢⼼㹡嬠灳歯履癟敮嵴⌨潭畤敬彜灳歯履癟敮⥴簠⸠洯摯汵獥瘯敮⁴⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥潴彷慷役数牥湩彧畨形潴獟潰敫㸢⼼㹡嬠潴屷睟祡彜数牥湩屧桟扵彜潴彜灳歯嵥⌨潭畤敬彜潴屷睟祡彜数牥湩屧桟扵彜潴彜灳歯⥥簠⸠洯摯汵獥琯潷睟祡灟敥楲杮簠渠愯簠簊㰠⁡慮敭∽潭畤敬癟彭景桟扵㸢⼼㹡嬠浶彜景彜畨嵢⌨潭畤敬彜浶彜景彜畨⥢簠⸠洯摯汵獥瘯⁭⁼⽮⁡੼⁼愼渠浡㵥洢摯汵彥浶潟彦灳歯≥㰾愯‾癛屭潟屦獟潰敫⡝洣摯汵履癟屭潟屦獟潰敫 ⁼⼮潭畤敬⽳浶簠渠愯簠ਊ⌣删獥畯捲獥ਊ⁼慎敭簠吠灹⁥੼⵼ⴭⴭ簭ⴭⴭⴭ੼⁼慛畺敲浲江杯慟慮祬楴獣睟牯獫慰散昮物睥污彬湡污瑹捩彳潷歲灳捡嵥栨瑴獰⼺爯来獩牴⹹整牲晡牯⹭潩瀯潲楶敤獲栯獡楨潣灲愯畺敲浲㈯㠮⸰⼰潤獣爯獥畯捲獥氯杯慟慮祬楴獣睟牯獫慰散 ⁼敲潳牵散簠簊嬠穡牵牥彭敲潳牵散束潲灵栮扵牟獥畯捲彥牧畯嵰栨瑴獰⼺爯来獩牴⹹整牲晡牯⹭潩瀯潲楶敤獲栯獡楨潣灲愯畺敲浲㈯㠮⸰⼰潤獣爯獥畯捲獥爯獥畯捲彥牧畯⥰簠爠獥畯捲⁥੼⁼慛畺敲浲牟獥畯捲彥牧畯⹰灳歯彥敲潳牵散束潲灵⡝瑨灴㩳⼯敲楧瑳祲琮牥慲潦浲椮⽯牰癯摩牥⽳慨桳捩牯⽰穡牵牥⽭⸲〸〮搯捯⽳敲潳牵散⽳敲潳牵散束潲灵 ⁼敲潳牵散簠簊嬠穡牵牥彭畳湢瑥朮瑡睥祡獟扵敮嵴栨瑴獰⼺爯来獩牴⹹整牲晡牯⹭潩瀯潲楶敤獲栯獡楨潣灲愯畺敲浲㈯㠮⸰⼰潤獣爯獥畯捲獥猯扵敮⥴簠爠獥畯捲⁥੼⁼慛畺敲浲獟扵敮⹴畨䅢畺敲楆敲慷汬畓湢瑥⡝瑨灴㩳⼯敲楧瑳祲琮牥慲潦浲椮⽯牰癯摩牥⽳慨桳捩牯⽰穡牵牥⽭⸲〸〮搯捯⽳敲潳牵散⽳畳湢瑥 ⁼敲潳牵散簠ਊ⌣䤠灮瑵ੳ簊丠浡⁥⁼敄捳楲瑰潩⁮⁼祔数簠䐠晥畡瑬簠删煥極敲⁤੼⵼ⴭⴭ簭ⴭⴭⴭⴭⴭⴭ簭ⴭⴭⴭ⵼ⴭⴭⴭⴭ㩼ⴭⴭⴭⴭ簺簊㰠⁡慮敭∽湩異彴慡彤畡楤湥散束瑡睥祡㸢⼼㹡嬠慡層慟摵敩据履束瑡睥祡⡝椣灮瑵彜慡層慟摵敩据履束瑡睥祡 ⁼穁牵⁥捡楴敶搠物捥潴祲琠湥湡⁴景琠敨朠瑡睥祡‮⁼獠牴湩恧簠渠愯簠礠獥簠簊㰠⁡慮敭∽湩異彴慡彤獩畳牥束瑡睥祡㸢⼼㹡嬠慡層楟獳敵屲束瑡睥祡⡝椣灮瑵彜慡層楟獳敵屲束瑡睥祡 ⁼穁牵⁥捡楴敶搠物捥潴祲琠湥湡⁴景琠敨朠瑡睥祡‮⁼獠牴湩恧簠渠愯簠礠獥簠簊㰠⁡慮敭∽湩異彴慡彤整慮瑮束瑡睥祡㸢⼼㹡嬠慡層瑟湥湡屴束瑡睥祡⡝椣灮瑵彜慡層瑟湥湡屴束瑡睥祡 ⁼穁牵⁥捡楴敶搠物捥潴祲琠湥湡⁴景琠敨朠瑡睥祡‮⁼獠牴湩恧簠渠愯簠礠獥簠簊㰠⁡慮敭∽湩異彴畳獢牣灩楴湯楟≤㰾愯‾獛扵捳楲瑰潩屮楟嵤⌨湩異屴獟扵捳楲瑰潩屮楟⥤簠匠扵捳楲瑰潩⁮摩‮⁼獠牴湩恧簠渠愯簠礠獥簠簊㰠⁡慮敭∽湩異彴浶灟獡睳牯≤㰾愯‾癛屭灟獡睳牯嵤⌨湩異屴癟屭灟獡睳牯⥤簠嘠⁭慰獳潷摲映牯琠敨愠浤湩‮⁼獠牴湩恧簠渠愯簠礠獥簠簊㰠⁡慮敭∽湩異彴浶畟敳湲浡≥㰾愯‾癛屭畟敳湲浡嵥⌨湩異屴癟屭畟敳湲浡⥥簠嘠⁭獵牥慮敭映牯琠敨愠浤湩‮⁼獠牴湩恧簠渠愯簠礠獥簠ਊ⌣传瑵異獴ਊ⁼慎敭簠䐠獥牣灩楴湯簠簊ⴭⴭⴭ⵼ⴭⴭⴭⴭⴭⴭ੼⁼愼渠浡㵥漢瑵異彴畨形楦敲慷汬楟≤㰾愯‾桛扵彜楦敲慷汬彜摩⡝漣瑵異屴桟扵彜楦敲慷汬彜摩 ⁼⽮⁡੼ℼⴭ䔠䑎呟彆佄千ⴠ㸭