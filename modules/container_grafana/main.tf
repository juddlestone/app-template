resource "azurerm_container_app" "grafana" {
  name                         = var.grafana_container_app_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  template {
    container {
      name   = var.grafana_container_app_name
      image  = "grafana/grafana-oss"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user_assigned_identity.id
    ]
  }

  tags = var.tags
}

resource "azurerm_storage_account" "azurerm_storage_account" {
  name                     = var.grafana_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_share" "azurerm_storage_share" {
  name               = "grafana"
  storage_account_id = azurerm_storage_account.azurerm_storage_account.id
  quota              = 10
}

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.grafana_user_assigned_identity_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}