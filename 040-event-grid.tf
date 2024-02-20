resource "azurerm_eventgrid_topic" "default" {
  name                = "${var.APP}-event-grid-topic"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

# todo: azurerm_eventgrid_event_subscription https://github.com/Azure-Samples/azure-functions-event-grid-terraform/blob/main/src/FunctionApp/Functions/EventGridFunction.cs