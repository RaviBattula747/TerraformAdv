resource "azurerm_private_dns_resolver" "az-apr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}