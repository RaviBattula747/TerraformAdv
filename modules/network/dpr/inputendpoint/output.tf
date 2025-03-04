output "out" {
  description = "Map all attribute values"
  value       = { for k, v in azurerm_private_dns_resolver_inbound_endpoint.inbound_endpoint : k => v }
}