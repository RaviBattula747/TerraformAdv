resource "azurerm_subnet" "az-subnet" {
	name					= var.name
	resource_group_name		= var.resource_group_name
	virtual_network_name	= var.virtual_network_name
	address_prefixes		= var.address_prefixes
	  lifecycle {
    ignore_changes = [
      delegation, service_endpoints
    ]
  }
}
