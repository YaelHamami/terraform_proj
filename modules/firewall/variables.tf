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

variable "firewall_public_ip_name" {
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

variable "rule_collection_name" {
  type        = string
  description = "The rule name."
}

variable "priority_rule" {
  type        = string
  description = "The priority of the rule."
}

variable "network_rules" {
  type = list(object({
    name                  = string,
    source_addresses      = list(string),
    destination_ports     = list(string),
    destination_addresses = list(string),
    protocols             = list(string)
  }))
  description = "List of the network rules."
}

# Workspace vars.
variable "fw_analytics_workspace_id" {
  type        = string
  description = "The analytic workspace id."
}
