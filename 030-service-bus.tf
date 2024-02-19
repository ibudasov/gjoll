resource "azurerm_servicebus_namespace" "default" {
  name                = "${var.APP}-servicebus-namespace"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard"
}

resource "azurerm_servicebus_queue" "default" {
  # https://www.youtube.com/watch?v=LM7DByKOHBs
  name         = "${var.APP}-servicebus-queue"
  namespace_id = azurerm_servicebus_namespace.default.id
  enable_partitioning = true
}