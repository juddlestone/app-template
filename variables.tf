variable "container_app_environment_name" {
  description = "The name of the container app environment."
}

variable "location" {
  description = "The location in which the container app environment will be deployed."
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace to be associated with the container app environment."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the container app will be deployed."
}

variable "tags" {
  description = "A mapping of tags to assign to the container app environment."
  type        = map(string)
  default     = {}
}