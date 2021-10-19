variable "route_table_name" {
  type        = string
  description = "The name of the route table."
}

variable "routes" {
  type        = list(object({
    name                   = string,
    address_prefix         = string,
    next_hop_type          = string,
    next_hop_in_ip_address = optional(string)
  }))
  description = "The routes."
}
variable "resource_group_name" {
  type        = string
  description = "The resource group name."
}
variable "location" {
  type        = string
  description = "The resource location."
}

variable "associated_subnet_id" {
  type        = string
  description = "The associated subnet."
}