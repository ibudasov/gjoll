resource "azurerm_container_app_environment" "default" {
  name                       = "${var.APP}-app-environment"
  location                   = azurerm_resource_group.default.location
  resource_group_name        = azurerm_resource_group.default.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.default.id
}
resource "azurerm_container_app" "default" {
  name                         = "${var.APP}-container-app"
  container_app_environment_id = azurerm_container_app_environment.default.id
  resource_group_name          = azurerm_resource_group.default.name
  revision_mode                = "Single"

  ingress {
    target_port      = 80     # Container port to receive traffic
    external_enabled = true   # Allow external access
    transport        = "http" # Optional, transport protocol (http, http2, tcp)
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "${var.APP}-container-app"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}