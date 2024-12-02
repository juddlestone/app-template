resource "azurerm_mysql_flexible_server" "azurerm_mysql_flexible_server" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.mysql_administrator_login
  administrator_password = var.mysql_administrator_login_password
  sku_name               = var.mysql_server_sku_name

  tags = var.tags
}

resource "azurerm_mysql_flexible_database" "example" {
  name                = "grafana"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.azurerm_mysql_flexible_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}