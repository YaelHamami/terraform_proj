variable "analytics_workspace_id" {
  type        = string
  description = "The analytics workspace id."
}

variable "target_resource_id" {
  type        = string
  description = "The id of the target resource that will be diagnose."
}
variable "diagnostic_setting_name" {
  type        = string
  description = "The diagnostic setting name"
}

variable "logs" {
  type        = list(object({
    category         = string,
    retention_policy = object({
      enabled = bool,
    })
  }))
  description = "List of logs for the diagnostic setting."
}
