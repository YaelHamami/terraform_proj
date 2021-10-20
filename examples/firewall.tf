locals {
  firewall_policy_name          = "hub-firewall-policy"
  firewall_public_ip_name       = "hub-firewall-public-ip"
  firewall_public_ip_sku        = "Standard"
  firewall_rule_collection_name = "allowTcp"
  firewall_name                 = "hub-firewall"
}

module "my_firewall" {
  source                 = "../modules/firewall"
  analytics_workspace_id = azurerm_log_analytics_workspace.my_workspace.id
  firewall_name          = "myFirewall"
  firewall_policy_name   = module.my_firewall_policy.name
  location               = "West Europe"
  public_ip_name         = "firewallPublicIp"
  public_ip_sku          = "Standard"
  resource_group_name    = "myResourceGroup"
  subnet_id              = module.my_vnet.subnets_ids["AzureFirewallSubnet"]

  rule_collection_groups = {
    first_rule_collection = {
      priority                     = 200
      name                         = "allowTcp"
      application_rule_collections = [
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
      nat_rule_collections         = [
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
      network_rule_collections     = [
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
    }
  }
}