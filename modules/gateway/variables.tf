variable "resource_group_name" {
  type        = string
  description = "Name of resource group."
}

variable "location" {
  type        = string
  description = "Location of resource group and all the resources in the module."
}

variable "subnet_id" {
  type        = string
  description = "The id of the gateway subnet."
}

variable "name" {
  type        = string
  description = "Name of gateway."
}

variable "sku" {
  type        = string
  description = "The gateway sku."
}
variable "generation" {
  type        = string
  description = "The gateway generation."
}

variable "is_active_active" {
  type        = bool
  default     = false
  description = "(Optional) If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku"
}

variable "public_ip_names" {
  type        = list(string)
  description = "Name of public ip of the gateway. is active-active is true enter 2 else enter 1"
}

variable "vpn_address_space" {
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