module "my_route_table" {
  source               = "../modules/route_table"
  associated_subnet_id = azurerm_subnet.my_subnet.id
  location             = "West Europe"
  resource_group_name  = "myResourceGroup"
  route_table_name     = "myRouteTable"
  routes               = [
    {
      "name" : "HubToFirewall",
      "address_prefix" : "${spoke_subnet_mask}",
      "next_hop_type" : "VirtualAppliance",
      "next_hop_in_ip_address" : "${fw_private_ip}"
    },
    {
      "name" : "AnyToFirewall",
      "address_prefix" : "0.0.0.0/0",
      "next_hop_type" : "VirtualAppliance",
      "next_hop_in_ip_address" : "${fw_private_ip}"
    }
  ]
}