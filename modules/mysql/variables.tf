variable "mysql_administrator_login" {
  description = "MySQL username"
}

variable "mysql_administrator_login_password" {
  description = "MySQL password"
  sensitive   = true
}

variable "location" {
  description = "Location for MySQL server"
}

variable "mysql_server_name" {
  description = "Name of MySQL server"
}

variable "resource_group_name" {
  description = "Name of resource group"
}

variable "mysql_server_sku_name" {
  description = "SKU name for MySQL server"
}

variable "tags" {
  description = "Tags for MySQL server"
}