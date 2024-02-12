resource "azurerm_storage_account" "default" {
  name                     = "${var.APP}storageacc"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "default" {
  name                = "${var.APP}-appserviceplan"
  location            = azurerm_resource_group.default.location
  sku_name            = "B1"
  resource_group_name = azurerm_resource_group.default.name
  os_type = "Linux"
}

resource "azurerm_function_app" "default" {
  name                       = "${var.APP}-functionapp"
  location                   = azurerm_resource_group.default.location
  resource_group_name        = azurerm_resource_group.default.name
  app_service_plan_id        = azurerm_service_plan.default.id
  storage_account_name       = azurerm_storage_account.default.name
  storage_account_access_key = azurerm_storage_account.default.primary_access_key

  site_config {
    linux_fx_version = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  }
}

