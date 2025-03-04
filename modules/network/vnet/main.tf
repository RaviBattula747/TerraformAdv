
resource "azurerm_virtual_network" "az-vnet" {

  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.location == "East US" ? ["10.133.0.228"] : ["10.130.0.228"]
        lifecycle {
      ignore_changes = [tags]
    }
}