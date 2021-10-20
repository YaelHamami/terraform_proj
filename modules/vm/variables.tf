variable "resource_group_name" {
  type        = string
  description = "The resource group name."
}

variable "location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "subnet_id" {
  type        = string
  description = "The id of the subnet the vm will be in."
}

variable "is_linux" {
  type        = bool
  description = "Is the vm has Linux os or Windows."
  default     = true
}

variable "vm_name" {
  type        = string
  description = "Name of vm."
}

variable "computer_name" {
  type        = string
  description = "The computer name."
}

variable "size" {
  type        = string
  description = "Size of the vm."
  default     = "Standard_LRS"
}

variable "disk_caching" {
  type        = string
  description = "Caching of the disk vm."
  default     = "ReadWrite"
}

variable "image_publisher" {
  type        = string
  description = "The vm image publisher."
}

variable "image_offer" {
  type        = string
  description = "The vm image offer."
}

variable "image_sku" {
  type        = string
  description = "The vm image sku."
  default     = "16.04-LTS"
}

variable "image_version" {
  type        = string
  description = "The vm image version."
}

variable "disk_storage_account_type" {
  type        = string
  description = "Type of the vm disk storage account."
}

variable "admin_username" {
  type        = string
  description = "Admin username of the vm."
}

variable "admin_password" {
  type        = string
  description = "Admin password of the vm."
  sensitive   = true
}

variable "managed_data_disks" {
  type        = list(object({
    name                 = string
    storage_account_type = string,
    create_option        = string,
    disk_size_gb         = string,
    lun                  = string,
    caching              = string
  }))
  description = "The data disks to attach (optional)."
  default     = []
}