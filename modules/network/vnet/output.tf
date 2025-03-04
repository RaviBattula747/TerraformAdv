output "vnet_name" {
  description = "The ID of the virtual network"
  value   = azurerm_virtual_network.az-vnet.name
}

output "vnet_resource_group_name" {
  description = "The rg of the virtual network"
  value   = azurerm_virtual_network.az-vnet.resource_group_name
}

output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k, v in azurerm_virtual_network.az-vnet : k => v }
}