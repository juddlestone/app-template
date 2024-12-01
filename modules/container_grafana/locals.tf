locals {
  grafana_environment_variables = {
    "GF_SECURITY_ADMIN_USER"              = "admin"
    "GF_SECURITY_ADMIN_PASSWORD"          = var.grafana_admin_password
    "GF_AZURE_MANAGED_IDENTITY_ENABLED"   = true
    "GF_AZURE_MANAGED_IDENTITY_CLIENT_ID" = azurerm_user_assigned_identity.user_assigned_identity.client_id
    "GF_DATABASE_TYPE"                    = "mysql"
    "GF_DATABASE_HOST"                    = azurerm_container_app.mysql.name
    "GF_DATABASE_USER"                    = "grafana"
    "GF_DATABASE_PASSWORD"                = azurerm_container_app.mysql.name

  }

  mysql_environment_variables = {
    "MYSQL_DATABASE" = "grafana"
    "MYSQL_PASSWORD" = var.grafana_admin_password
    "MYSQL_USER"     = "grafana"
  }

  subscription_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
}