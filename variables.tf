variable "subscription_id" {
  type        = string
  description = "Subscription id."
  sensitive   = true
}

# VPN vars.
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

# VM (hub and spoke) vars
variable "vm_username" {
  type        = string
  description = "Vm username for the admin."
  sensitive   = true
}

variable "vm_password" {
  type        = string
  description = "Vm password for the admin."
  sensitive   = true
}