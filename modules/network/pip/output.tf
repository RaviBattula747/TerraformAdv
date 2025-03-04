
output "out" {
  description = "Map of Subnet names to IDs"
  value       = { for k, v in azurerm_public_ip.az-pip : k => v }
}