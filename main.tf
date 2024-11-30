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
  tags                           = var.tags
}

module "grafana" {
  source                              = "./modules/container_grafana"
  grafana_container_app_name          = var.grafana_container_app_name
  grafana_user_assigned_identity_name = var.grafana_user_assigned_identity_name
  container_app_environment_id        = module.container_app_environment.container_app_environment_id
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  tags                                = var.tags
}