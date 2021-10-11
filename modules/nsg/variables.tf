variable "rg_name" {
  type        = string
  description = "Name of rg."
}

variable "all_resources_location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "associated_subnet_id" {
  type = string
  description = "The id of subnet in which the nsg will associate with."
}

variable "security_rules" {
  type = list(object({
    name                       = string,
    priority                   = number,
    direction                  = string,
    access                     = string,
    protocol                   = string,
    source_port_range          = string,
    destination_port_range     = string,
    source_address_prefix      = string,
    destination_address_prefix = string,
  }))
}

