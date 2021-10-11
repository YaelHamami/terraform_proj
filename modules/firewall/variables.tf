variable "rg_name" {
  type = string
  description = "The resource group name."
}

variable "all_resources_location" {
  type = string
  description = "All resources location."
}

variable "firewall_policy_name" {
  type = string
  description = "The firewall policy name."
}

variable "firewall_public_ip_name" {
  type        = string
  description = "Name of public ip of the firewall."
}

variable "subnet_id" {
  type = string
  description = "Id of the subnet of the firewall."
}

variable "rule_name" {
  type = string
  description = "The rule name."
}
#variable "list_source_addresses" {
#  type = list(string)
#  description = "List of the source addresses."
#}
#variable "list_destination_ports" {
#  type = list(string)
#  description = "List of the destination ports."
#}
#variable "list_destination_addresses" {
#  type = list(string)
#  description = "List of the destination addresses."
#}
#variable "list_rule_protocols" {
#  type = list(string)
#  description = "Protocol of the rule."
#}
variable "priority_rule" {
  type = string
  description = "The priority of the rule."
}

variable "network_rules" {
  type = list(object({
  name = string,
  source_addresses = list(string),
  destination_ports = list(string),
  destination_addresses = list(string),
  protocols = list(string)
  }))
}


