output "out" {
  description = "Map all attribute values"
  value       = { for k, v in azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint : k => v }
}