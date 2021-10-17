variable "resource_group_name" {
  type        = string
  description = "Name of rg."
}

variable "location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "gateway_subnet_id" {
  type        = string
  description = "The id of the gateway subnet."
}

variable "gateway_name" {
  type        = string
  description = "Name of gateway."
}

variable "gateway_sku" {
  type        = string
  description = "The gateway sku."
}
variable "gateway_generation" {
  type        = string
  description = "The gateway generation."
}

variable "gateway_public_ip_name" {
  type        = string
  description = "Name of public ip of the gateway."
}

variable "gateway_vpn_address_space" {
  type        = list(string)
  description = "Address Space of VPN gateway client."
}

variable "aad_tenant_gateway" {
  type        = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}

variable "aad_audience_gateway" {
  type        = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}

variable "aad_issuer_gateway" {
  type        = string
  description = "Azure active directory tenant of the gateway."
  sensitive   = true
}