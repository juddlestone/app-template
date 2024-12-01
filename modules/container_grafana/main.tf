data "azurerm_subscription" "current" {
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

# Grafana
resource "azurerm_container_app" "grafana" {
  name                         = var.grafana_container_app_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  template {
    container {
      name   = var.grafana_container_app_name
      image  = "grafana/grafana-oss"
      cpu    = 0.25
      memory = "0.5Gi"

      volume_mounts {
        name = "grafana"
        path = "/var/lib/grafana"
      }

      dynamic "env" {
        for_each = local.grafana_environment_variables
        content {
          name  = env.key
          value = env.value
        }
      }
    }

    volume {
      name         = "grafana"
      storage_name = "grafana"
      storage_type = "AzureFile"
    }
  }

  ingress {
    target_port      = "3000"
    external_enabled = true

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user_assigned_identity.id
    ]
  }

  lifecycle {
    replace_triggered_by = [azurerm_container_app_environment_storage.grafana_container_app_environment_storage.id]
  }

  tags = var.tags
}

resource "azurerm_storage_share" "grafana_storage_share" {
  name               = "grafana"
  storage_account_id = data.azurerm_storage_account.storage_account.id
  quota              = 10
}

resource "azurerm_container_app_environment_storage" "grafana_container_app_environment_storage" {
  name                         = "grafana"
  container_app_environment_id = var.container_app_environment_id
  account_name                 = data.azurerm_storage_account.storage_account.name
  access_key                   = data.azurerm_storage_account.storage_account.primary_access_key
  access_mode                  = "ReadWrite"
  share_name                   = "grafana"
}

# MySQL
resource "azurerm_container_app" "mysql" {
  name                         = var.grafana_container_db_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  template {
    container {
      name   = var.grafana_container_db_name
      image  = "mysql/mysql-server"
      cpu    = 0.25
      memory = "0.5Gi"

      volume_mounts {
        name = "mysql"
        path = "/var/lib/mysql"
      }

      dynamic "env" {
        for_each = local.mysql_environment_variables
        content {
          name  = env.key
          value = env.value
        }
      }
    }

    volume {
      name         = "mysql"
      storage_name = "mysql"
      storage_type = "AzureFile"
    }
  }

  ingress {
    target_port      = "3306"
    external_enabled = false

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  lifecycle {
    replace_triggered_by = [azurerm_container_app_environment_storage.mysql_container_app_environment_storage.id]
  }

  tags = var.tags
}

resource "azurerm_storage_share" "mysql_storage_share" {
  name               = "mysql"
  storage_account_id = data.azurerm_storage_account.storage_account.id
  quota              = 10
}

resource "azurerm_container_app_environment_storage" "mysql_container_app_environment_storage" {
  name                         = "mysql"
  container_app_environment_id = var.container_app_environment_id
  account_name                 = data.azurerm_storage_account.storage_account.name
  access_key                   = data.azurerm_storage_account.storage_account.primary_access_key
  access_mode                  = "ReadWrite"
  share_name                   = "mysql"
}

# User Assigned Identity
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.grafana_user_assigned_identity_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = local.subscription_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}