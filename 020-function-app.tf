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
  os_type             = "Linux"
}

resource "azurerm_linux_function_app" "default" {
  name                       = "${var.APP}-functionapp"
  location                   = azurerm_resource_group.default.location
  resource_group_name        = azurerm_resource_group.default.name
  service_plan_id            = azurerm_service_plan.default.id
  storage_account_name       = azurerm_storage_account.default.name
  storage_account_access_key = azurerm_storage_account.default.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    "WEBSITE_RUN_FROM_PACKAGE" = 1
  }

  # https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-custom-container?tabs=vs-code%2Cdocker%2Cazure-cli&pivots=azure-functions
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app#site_config
  site_config {
    health_check_path = "/"
    always_on         = "true"
    application_stack {
      docker {
        # https://mcr.microsoft.com/catalog?search=functions
        registry_url = "mcr.microsoft.com"
        image_name   = "azure-functions/python"
        image_tag    = "4-nightly-python3.11"
      }
    }
  }
}

