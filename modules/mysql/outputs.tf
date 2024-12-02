output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.azurerm_mysql_flexible_server.fqdn
}

output "mysql_administrator_login" {
  value = azurerm_mysql_flexible_server.azurerm_mysql_flexible_server.administrator_login
}

output "mysql_administrator_login_password" {
  value     = azurerm_mysql_flexible_server.azurerm_mysql_flexible_server.administrator_password
  sensitive = true
}