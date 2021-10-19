module "my_network_security_group" {
  source                 = "../modules/nsg"
  associated_subnets_ids = [module.my_vnet.subnets_ids["subnetVm"]]
  location               = "West Europe"
  resource_group_name    = "myResourceGroup"
  security_group_name    = module.my_network_security_group.name
  security_rules         = [
    {
      "name" : "AllowSshInboundFromSpoke",
      "priority" : 110,
      "direction" : "Inbound",
      "access" : "Allow",
      "protocol" : "Tcp",
      "source_port_ranges" : ["0-65535"],
      "destination_port_ranges" : ["22"],
      "source_address_prefix" : "${spoke_subnet_mask}",
      "destination_address_prefix" : "*"
    },
    {
      "name" : "AllowSshOutbound",
      "priority" : 110,
      "direction" : "Outbound",
      "access" : "Allow",
      "protocol" : "Tcp",
      "source_port_ranges" : ["0-65535"],
      "destination_port_ranges" : ["22"],
      "source_address_prefix" : "*",
      "destination_address_prefix" : "${spoke_subnet_mask}"
    }
  ]
}