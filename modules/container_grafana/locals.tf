locals {
  grafana_environment_variables = {
    "GF_AZURE_MANAGED_IDENTITY_ENABLED"   = true
    "GF_AZURE_MANAGED_IDENTITY_CLIENT_ID" = azurerm_user_assigned_identity.user_assigned_identity.client_id
    "GF_DATABASE_MIGRATION_LOCKING"       = "false"
  }

  subscription_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
}