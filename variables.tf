variable "container_app_environment_name" {
  description = "The name of the container app environment."
}

variable "grafana_container_app_name" {
  description = "The name of the grafana container app."
}

variable "grafana_admin_password" {
  description = "The password for the grafana admin user."
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

variable "storage_account_name" {
  description = "The name of the storage account to be created for the grafana container."
}

variable "tags" {
  description = "A mapping of tags to assign to the container app environment."
  type        = map(string)
  default     = {}
}

variable "grafana_user_assigned_identity_name" {
  description = "The name of the user assigned identity to be created for the grafana container."
}

variable "mysql_administrator_login" {
  description = "The administrator login for the MySQL server."
}

variable "mysql_administrator_login_password" {
  description = "The administrator login password for the MySQL server."
  sensitive   = true
}

variable "mysql_server_name" {
  description = "The name of the mysql server."
}

variable "mysql_server_sku_name" {
  description = "The sku name of the mysql server."
  default     = "B_Standard_B1ms"
}