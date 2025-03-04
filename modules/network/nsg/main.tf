
resource "azurerm_network_security_group" "az-nsg"{
	name			= var.name
	location		= var.location
	resource_group_name	= var.resource_group_name
        lifecycle {
      ignore_changes = [tags]
    }
}
