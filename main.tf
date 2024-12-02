resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "container_app_environment" {
  source                         = "./modules/container_app_environment"
  container_app_environment_name = var.container_app_environment_name
  resource_group_name            = azurerm_resource_group.resource_group.name
  location                       = azurerm_resource_group.resource_group.location
  log_analytics_workspace_name   = var.log_analytics_workspace_name
  storage_account_name           = var.storage_account_name
  tags                           = var.tags
}

module "grafana" {
  source                       = "./modules/container_grafana"
  container_app_environment_id = module.container_app_environment.container_app_environment_id
  log_analytics_workspace_id   = module.container_app_environment.log_analytics_workspace_id
  storage_account_name         = var.storage_account_name
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location

  grafana_container_app_name          = var.grafana_container_app_name
  grafana_container_db_name           = var.grafana_container_db_name
  grafana_user_assigned_identity_name = var.grafana_user_assigned_identity_name
  grafana_admin_password              = var.grafana_admin_password

  mysql_administrator_login          = module.database.mysql_administrator_login
  mysql_administrator_login_password = module.database.mysql_administrator_login_password
  mysql_server_fqdn                  = module.database.mysql_server_fqdn
  tags                               = var.tags

  depends_on = [module.container_app_environment]
}

module "database" {
  source                             = "./modules/mysql"
  mysql_administrator_login          = var.mysql_administrator_login
  mysql_administrator_login_password = var.mysql_administrator_login_password
  mysql_server_sku_name              = var.mysql_server_sku_name
  mysql_server_name                  = var.mysql_server_name
  location                           = azurerm_resource_group.resource_group.location
  resource_group_name                = azurerm_resource_group.resource_group.name
  tags                               = var.tags
}