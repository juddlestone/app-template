output "container_app_environment_id" {
  description = "The ID of the container app environment."
  value       = azurerm_container_app_environment.container_app_environment.id
}

output "default_domain_name" {
  description = "The default domain name of the container app environment."
  value       = azurerm_container_app_environment.container_app_environment.default_domain
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace associated with the container app environment."
  value       = azurerm_container_app_environment.container_app_environment.log_analytics_workspace_id
}

output "storage_account_id" {
  description = "The ID of the storage account associated with the container app environment."
  value       = azurerm_storage_account.azurerm_storage_account.id
}