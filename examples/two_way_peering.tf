module "my_two_way_peering" {
  source                        = "../modules/two_way_peering"
  allow_forwarded_traffic_vnet1 = false
  allow_forwarded_traffic_vnet2 = false
  allow_gateway_transit_vnet1   = false
  peer_vnet1_to_vnet2_name      = "peerHostToRemoteVnet"
  peer_vnet2_to_vnet1_name      = "peerRemoteToHostVnet"
  use_remote_gateways_vnet2     = false
  vnet1_id                      = module.my_vnet.virtual_network_id
  vnet2_id                      = azurerm_virtual_network.vnet.id
  vnet1_name                    = "hostVnet"
  vnet2_name                    = "remoteVnet"
  vnet1_resource_group_name     = "remoteHostResourceGroup"
  vnet2_resource_group_name     = "remoteVnetResourceGroup"
}