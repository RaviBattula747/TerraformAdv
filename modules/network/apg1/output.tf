/*output "application_gateway_id" {
  description = "The ID of the application gateway."
  value       = azurerm_application_gateway.this.id
}

output "frontend_ip_configuration_ids" {
  description = "The IDs of the frontend IP configurations."
  value       = [for ip_config in azurerm_application_gateway.this.frontend_ip_configuration : ip_config.id]
}

output "backend_address_pool_ids" {
  description = "The IDs of the backend address pools."
  value       = [for pool in azurerm_application_gateway.this.backend_address_pool : pool.id]
}

output "http_listener_ids" {
  description = "The IDs of the HTTP listeners."
  value       = [for listener in azurerm_application_gateway.this.http_listener : listener.id]
}
*/