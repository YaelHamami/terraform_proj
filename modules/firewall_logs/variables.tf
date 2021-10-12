variable "rg_name" {
  type = string
  description = "Name of rg."
}

variable "all_resources_location" {
  type = string
  description = "Location of rg and all the resources in the module."
}

variable "analytics_workspace_name" {
  type = string
  description = "The analytics workspace name."
}

variable "target_resource_id" {
  type = string
  description = "The id of the target resource that will be diagnose."
}
variable "diagnostic_setting_name" {
  type = string
  description = "The diagnostic setting name"
}

variable "logs" {
  type = list(
  object({
    category         = string,
    retention_policy = object({
      enabled = bool,
      days    = number
    })
  }))
  description = "List of logs for the diagnostic setting."
}
