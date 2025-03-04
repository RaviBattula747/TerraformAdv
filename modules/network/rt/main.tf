resource "azurerm_route_table" "az-rt" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  bgp_route_propagation_enabled = true
      lifecycle {
      ignore_changes = [tags]
    }
}