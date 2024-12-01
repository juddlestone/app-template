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
  source                              = "./modules/container_grafana"
  grafana_container_app_name          = var.grafana_container_app_name
  grafana_container_db_name           = var.grafana_container_db_name
  grafana_user_assigned_identity_name = var.grafana_user_assigned_identity_name
  grafana_admin_password              = var.grafana_admin_password
  container_app_environment_id        = module.container_app_environment.container_app_environment_id
  log_analytics_workspace_id          = module.container_app_environment.log_analytics_workspace_id
  storage_account_name                = var.storage_account_name
  resource_group_name                 = azurerm_resource_group.resource_group.name
  location                            = azurerm_resource_group.resource_group.location
  tags                                = var.tags

  depends_on = [ module.container_app_environment ]
}