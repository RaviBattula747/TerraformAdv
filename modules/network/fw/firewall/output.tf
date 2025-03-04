output "id" {
  description = "Map id values"
  value       = azurerm_palo_alto_virtual_network_appliance.nva.id
}

output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k, v in azurerm_palo_alto_virtual_network_appliance.nva : k => v }
}