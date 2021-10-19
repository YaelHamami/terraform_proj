variable "virtual_network_address_space" {
  type        = list(string)
  description = "List of addresses for the virtual network."
}
variable "location" {
  type        = string
  description = "All module resources location."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name of all module's resources."
}

