variable "resource_group_name" {
  type        = string
  description = "Name of rg."
}

variable "location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "vm_subnet_id" {
  type        = string
  description = "The id of the subnet the vm will be in."
}

variable "vm_name" {
  type        = string
  description = "Name of vm."
}

variable "vm_size" {
  type        = string
  description = "Size of the vm."
}

variable "vm_disk_caching" {
  type        = string
  description = "Caching of the disk vm."
}

variable "vm_image_publisher" {
  type        = string
  description = "The vm image publisher."
}

variable "vm_image_offer" {
  type        = string
  description = "The vm image offer."
}

variable "vm_image_sku" {
  type        = string
  description = "The vm image sku."
}

variable "vm_image_version" {
  type        = string
  description = "The vm image version."
}

variable "vm_disk_storage_account_type" {
  type        = string
  description = "Type of the vm disk storage account."
}

variable "nic_name" {
  type        = string
  description = "Name of nic."
}

variable "admin_username" {
  type        = string
  description = "Admin username of the vm."
}

variable "admin_password" {
  type        = string
  description = "Admin password of the vm."
}

variable "managed_disks" {
  type = list(object({
    name                 = string
    storage_account_type = string,
    create_option        = string,
    disk_size_gb         = string,
    lun                  = string,
    caching              = string
  }))
}

