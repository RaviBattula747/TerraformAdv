output "rt_resource_group_name" {
  description = "The rg of the route table"
  value   = azurerm_route_table.az-rt.resource_group_name
}

output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k , v in  azurerm_route_table.az-rt : k => v }
}