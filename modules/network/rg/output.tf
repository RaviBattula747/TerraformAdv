output "out" {
  description = "Map of all resource group attributes"
  value       = { for k , v in  azurerm_resource_group.az-rg : k => v }
}