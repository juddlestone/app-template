output "default_domain_name" {
  description = "The default domain name of the container app environment."
  value       = azurerm_container_app_environment.container_app_environment.default_domain
}