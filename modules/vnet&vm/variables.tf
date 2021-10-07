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

variable "vnet_address" {
  type = string
  description = "Address of vnet."
}

variable "gw_subnet_name" {
  type = string
  description = "Name of subnet with the gateway."
}

variable "gw_subnet_address" {
  type = string
  description = "Address of subnet with the gateway."
}

variable "vm_subnet_name" {
  type = string
  description = "Name of subnet with the vm."
}

variable "vm_subnet_address" {
  type = string
  description = "Address of subnet with the vm."
}

variable "vm_name" {
  type = string
  description = "Name of vm."
}

variable "vm_size" {
  type = string
  description = "Size of the vm."
}

variable "vm_disk_caching" {
  type = string
  description = "Caching of the disk vm."
}

variable "vm_image_publisher" {
  type = string
  description = "The vm image publisher."
}

variable "vm_image_offer" {
  type = string
  description = "The vm image offer."
}

variable "vm_image_sku" {
  type = string
  description = "The vm image sku."
}

variable "vm_image_version" {
  type = string
  description = "The vm image version."
}

variable "vm_disk_storage_account_type" {
  type = string
  description = "Type of the vm disk storage account."
}

variable "nic_name" {
  type = string
  description = "Name of nic."
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