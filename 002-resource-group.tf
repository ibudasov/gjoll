resource "azurerm_resource_group" "default" {
  name     = "${var.APP}-resource-group"
  location = "West Europe"
}
