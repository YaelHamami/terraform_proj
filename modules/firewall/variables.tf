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

variable "public_ip_name" {
  type        = string
  description = "Name of public ip of the firewall."
}

variable "public_ip_sku" {
  type        = string
  description = "The firewall sku."
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet of the firewall."
}

variable "firewall_name" {
  type = string
  description = "The firewall name."
}

# Workspace vars.
variable "analytics_workspace_id" {
  type        = string
  description = "The analytic workspace id."
}

# Rule collection vars.
variable "rule_collection_name" {
  type        = string
  description = "The rule name."
}

variable "priority_rule_collection_group" {
  type        = string
  description = "The priority of the rule collection group."
}

variable "network_rule_collections" {
  type        = list(object({
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
  }))
  description = "List of the network rule collection."
}

# Rule collection vars.
variable "application_rule_collections" {
  type        = list(object({
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
  }))
  description = "List of the application rule collection."
}

variable "nat_rule_collections" {
  type        = list(object({
    rule_collection_name = string
    priority             = number
    action               = string
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
  description = "List of the nat rule collection."
}

