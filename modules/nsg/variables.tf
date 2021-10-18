variable "security_group_name" {
  type        = string
  description = "The nam eof the network security group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of rg."
}

variable "location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "security_rules" {
  type = list(object({
    name                       = string,
    priority                   = number,
    direction                  = string,
    access                     = string,
    protocol                   = string,
    //source_port_range          = string,
    source_port_ranges         = list(string),
    //destination_port_range     = string,
    destination_port_ranges    = list(string),
    source_address_prefix      = string,
    destination_address_prefix = string,
  }))
  description = "List of the ids of subnets in which the nsg will associate with."
}

