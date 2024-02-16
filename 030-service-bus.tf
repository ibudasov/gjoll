resource "azurerm_resource_group" "default" {
  name     = "${var.APP}-servicebus"
  location = azurerm_resource_group.default.location
}

resource "azurerm_servicebus_namespace" "default" {
  name                = "${var.APP}-servicebus-namespace"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "default" {
  name         = "${var.APP}_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.default.id

  enable_partitioning = true
}