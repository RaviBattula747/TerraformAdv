output "nsg_resource_group_name" {
  description = "The rg of the network security group"
  value   = azurerm_network_security_group.az-nsg.resource_group_name
}

output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k, v in azurerm_network_security_group.az-nsg : k => v }
}