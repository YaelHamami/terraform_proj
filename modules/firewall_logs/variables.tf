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