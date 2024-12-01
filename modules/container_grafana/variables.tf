variable "container_app_environment_id" {
  description = "The id of the parent container app environment."
}

variable "grafana_container_app_name" {
  description = "The name of the grafana container app."
}

variable "grafana_admin_password" {
  description = "The password for the grafana admin user."
}

variable "location" {
  description = "The location in which the grafana be deployed."
}

variable "log_analytics_workspace_id" {
  description = "The id of the Log Analytics workspace associated with the grafana."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the grafana will be deployed."
}

variable "grafana_storage_account_name" {
  description = "The name of the storage account to be created for the grafana container."
}

variable "tags" {
  description = "A mapping of tags to assign to the grafana container."
  type        = map(string)
  default     = {}
}

variable "grafana_user_assigned_identity_name" {
  description = "The name of the user assigned identity to be created for the grafana container."
}