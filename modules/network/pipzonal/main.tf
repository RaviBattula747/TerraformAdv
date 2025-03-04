resource "azurerm_public_ip" "az-pip-zone" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  zones               = var.zones
  allocation_method   = "Static"
  sku                 = "Standard"
  ddos_protection_mode= "Disabled"   
    lifecycle {
    ignore_changes = [tags]
  }
}