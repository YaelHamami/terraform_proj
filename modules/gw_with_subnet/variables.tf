variable "rg_name" {
  type = string
  description = "Name of rg."
}

variable "location" {
  type = string
  description = "Location of rg and all the resources in the module."
}

 variable "vnet_name" {
   type = string
   description = "Name of vnet."
 }

variable "gw_subnet_name" {
  type = string
  description = "Name of subnet with the gateway."
}

variable "gw_subnet_address" {
  type = string
  description = "Address of subnet with the gateway."
}

variable "gw_name" {
  type = string
  description = "Name of gateway."
}

variable "gw_public_ip_name" {
  type        = string
  description = "Name of public ip of the gateway."
}

variable "gw_vpn_address_space" {
  type = list(string)
  description = "Address Space of VPN gateway client."
}

variable "aad_tenant_gw" {
  type = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}

variable "aad_audience_gw" {
  type = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}

variable "aad_issuer_gw" {
  type = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}