resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "container_app_environment" {
  source                         = "./modules/container_app_environment"
  container_app_environment_name = var.container_app_environment_name
  resource_group_name            = azurerm_resource_group.resource_group.name
  location                       = var.location
  log_analytics_workspace_name   = var.log_analytics_workspace_name
  tags                           = var.tags
}