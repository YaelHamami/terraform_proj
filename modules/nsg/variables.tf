variable "security_group_name" {
  type        = string
  description = "The nam eof the network security group."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name."
}

variable "location" {
  type        = string
  description = "Location of rg and all the resources in the module."
}

variable "security_rules" {
  type        = list(object({
    name                         = string,
    priority                     = number,
    direction                    = string,
    access                       = string,
    protocol                     = string,
    source_port_range            = optional(string),
    source_port_ranges           = optional(list(string)),
    destination_port_range       = optional(string),
    destination_port_ranges      = optional(list(string)),
    source_address_prefix        = optional(string),
    source_address_prefixes      = optional(list(string)),
    destination_address_prefix   = optional(string),
    destination_address_prefixes = optional(list(string))
  }))
  description = <<DESCRIPTION
                      List of the ids of subnets in which the nsg will associate with.
                      about the optional attributes, you must have one of the fields between the singular and the multiple
                      choose one between:
                      - source_port_range and source_port_ranges,
                      - destination_port_range and destination_port_ranges
                      - source_address_prefix and source_address_prefixes
                      - destination_address_prefix and destination_address_prefixes
  DESCRIPTION
}

variable "associated_subnets_ids" {
  type        = list(string)
  description = "list of ids to associate with the network security group."
}

