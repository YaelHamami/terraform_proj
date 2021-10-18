# Peer1to2 vars
variable "peer_vnet1_to_vnet2_name" {
  type        = string
  description = "The name peering virtual network 1 to 2."
}
variable "vnet1_resource_group_name" {
  type        = string
  description = "The name of vnet1 resource group."
}
variable "vnet2_resource_group_name" {
  type        = string
  description = "The name of vnet2 resource group."
}
variable "vnet1_name" {
  type        = string
  description = "The name of one vnet to peer (1)."

}
variable "vnet2_id" {
  type        = string
  description = "The id of other vnet to peer (1)."

}
variable "allow_forwarded_traffic_vnet1" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed for virtual network 1."
}
variable "allow_gateway_transit_vnet1" {
  type = bool
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the virtual network 1."
}

# Peer2to1 vars
variable "peer_vnet2_to_vnet1_name" {
  type        = string
  description = "The name peering virtual network 2 to 1."
}
variable "vnet2_name" {
  type        = string
  description = "The name of other vnet to peer (2)."

}
variable "vnet1_id" {
  type        = string
  description = "The id of other vnet to peer (2)."
}
variable "allow_forwarded_traffic_vnet2" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed for virtual network 2."
}
variable "use_remote_gateways_vnet2" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit."
}