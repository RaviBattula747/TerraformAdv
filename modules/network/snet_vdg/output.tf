
output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k, v in azurerm_subnet.az-subnet : k => v }
}