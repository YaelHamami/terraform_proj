module "my_firewall_policy" {
  source                         = "../modules/firewall_policy"
  priority_rule_collection_group = ""
  firewall_policy_name           = "myFirewallPlicy"
  location                       = "West Europe"
  resource_group_name            = "myResourceGroup"
  application_rule_collections   = [
    {
      "name" : "applicationRuleCollection",
      "priority" : 400,
      "action" : "Allow",
      "rules" : [
        {
          "name" : "rule1",
          "protocols" : [
            {
              "name" : "port80",
              "type" : "Http",
              "port" : 80
            },
            {
              "name" : "port443",
              "type" : "Https",
              "port" : 443
            }
          ],
          "source_addresses" : ["*"],
          "destination_fqdns" : ["*.microsoft.com"]
        }
      ]
    }
  ]
  nat_rule_collections           = [
    {
      "rule_collection_name" : "natRuleCollection",
      "priority" : 200,
      "action" : "Dnat",
      "rule" : {
        "name" : "natRule",
        "protocols" : ["TCP"],
        "source_addresses" : ["20.0.0.1"],
        "destination_address" : "20.103.1.189",
        "destination_ports" : ["80"],
        "translated_address" : "192.168.0.1",
        "translated_port" : "8080"
      }
    }
  ]
  network_rule_collections       = [
    {
      "name" : "allowTcp",
      "priority" : 300,
      "action" : "Allow",
      "rules" : [
        {
          "name" : "allowTcpHubToSpoke",
          "source_addresses" : ["${hub_subnet_mask}"],
          "destination_ports" : ["22"],
          "destination_addresses" : ["${spoke_subnet_mask}"],
          "protocols" : ["TCP"]
        }
      ]
    }
  ]
  rule_collection_groups         = {
    rule_collection_group = {
      rule_collection_name = "myRuleCollectionGroup"
    }
  }
}