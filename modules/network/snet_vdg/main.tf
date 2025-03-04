resource "azurerm_subnet" "az-subnet" {
	name					= var.name
	resource_group_name		= var.resource_group_name
	virtual_network_name	= var.virtual_network_name
	address_prefixes		= var.address_prefixes

    delegation {
    name = "PowerPlatformDelegation"

    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
    }
	  lifecycle {
    ignore_changes = [
       service_endpoints
    ]
  }
}
