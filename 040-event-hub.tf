resource "azurerm_eventhub_namespace" "default" {
  name                = "${var.APP}-event-hub-ns"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard"
  capacity            = 1
}

resource "azurerm_eventhub" "default" {
  name                = "${var.APP}-event-hub"
  namespace_name      = azurerm_eventhub_namespace.default.name
  resource_group_name = azurerm_resource_group.default.name
  partition_count     = 2
  message_retention   = 1
}