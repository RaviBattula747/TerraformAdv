resource "azurerm_network_security_rule" "az-nsg-rule1"{
		name							= var.name
		priority						= var.priority
		direction						= var.direction
		access							= var.access
		protocol						= var.protocol
		source_port_range				= "*"
		destination_port_ranges			= var.destination_port_ranges
		source_address_prefix			= var.source_address_prefix
		destination_address_prefix	= var.destination_address_prefix
		resource_group_name         	= var.resource_group_name
  		network_security_group_name 	= var.network_security_group_name
}