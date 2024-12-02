locals {
  grafana_environment_variables = {
    "GF_SECURITY_ADMIN_USER"              = "admin"
    "GF_SECURITY_ADMIN_PASSWORD"          = var.grafana_admin_password
    "GF_AZURE_MANAGED_IDENTITY_ENABLED"   = true
    "GF_AZURE_MANAGED_IDENTITY_CLIENT_ID" = azurerm_user_assigned_identity.user_assigned_identity.client_id
    "GF_DATABASE_TYPE"                    = "mysql"
    "GF_DATABASE_HOST"                    = var.mysql_server_fqdn
    "GF_DATABASE_USER"                    = var.mysql_administrator_login
    "GF_DATABASE_PASSWORD"                = var.mysql_administrator_login_password
  }

  subscription_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
}