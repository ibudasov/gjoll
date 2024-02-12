resource "null_resource" "provider_registration" {
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/23195
  provisioner "local-exec" {
    # https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-cli
    command = "az provider register --namespace 'Microsoft.App'"
  }
}
