resource "azurerm_route" "az-rt-rule1" {

  name                = var.name
  resource_group_name = var.resource_group_name
  route_table_name    = var.route_table_name
  address_prefix      = var.address_prefix
  next_hop_type       = var.next_hop_type
}