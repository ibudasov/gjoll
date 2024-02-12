resource "azurerm_resource_group" "default" {
  name     = "${var.APP}-resource-group"
  location = "West Europe"
}

resource "azurerm_log_analytics_workspace" "default" {
  name                = "${var.APP}-logs"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

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

  template {
    container {
      name   = "${var.APP}-container-app"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}