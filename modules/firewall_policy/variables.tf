variable "resource_group_name" {
  type        = string
  description = "The resource group name."
}

variable "location" {
  type        = string
  description = "All resources location."
}

variable "firewall_policy_name" {
  type        = string
  description = "The firewall policy name."
}

variable "rule_collection_groups" {
  type        = map(object({
    name                         = string,
    priority                     = string,
    network_rule_collections     = list(object({
      name     = string,
      priority = number,
      action   = string,
      rules    = list(object({
        name                  = string,
        source_addresses      = list(string),
        destination_ports     = list(string),
        destination_addresses = list(string),
        protocols             = list(string)
      }))
    })),
    application_rule_collections = list(object({
      name     = string,
      priority = number,
      action   = string,
      rules    = list(object({
        name              = string,
        protocols         = list(object({
          type = string,
          port = number
        }))
        source_addresses  = list(string),
        destination_fqdns = list(string),
      }))
    })),
    nat_rule_collections          = list(object({
      rule_collection_name = string
      priority             = number
      action               = optional(string)
      rule                 = object({
        name                = string
        protocols           = list(string)
        source_addresses    = list(string)
        destination_address = string
        destination_ports   = list(string)
        translated_address  = string
        translated_port     = string
      })
    }))
  }))
  description = "Map of the rule collection groups."
}