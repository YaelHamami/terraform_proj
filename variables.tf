variable "subscription_id" {
  type        = string
  description = "Subscription id."
  sensitive   = true
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