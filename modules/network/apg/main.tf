resource "azurerm_application_gateway" "az-apg" {
  for_each = var.apg

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

frontend_ip_configuration {
      name                 = each.value.frontend_ip_configurations.name
      private_ip_address   = each.value.frontend_ip_configurations.private_ip_address
      subnet_id            = each.value.frontend_ip_configurations.subnet_id
      private_ip_address_allocation = "Static"
    }

  frontend_ip_configuration {
    name                 = "apg-ipv4-public-ip"
    public_ip_address_id = each.value.frontend_ip_configurations.public_ip_address_id
  }

  dynamic "frontend_port" {
    for_each = each.value.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      /*
      host_name                      = http_listener.value.host_name
      host_names                     = http_listener.value.host_names
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      */


    }
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_pools
    content {
      name = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses
      }
    }


  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings
    content {
      name                    = backend_http_settings.value.name
      port                    = backend_http_settings.value.port
      protocol                = backend_http_settings.value.protocol
      cookie_based_affinity   = backend_http_settings.value.cookie_based_affinity
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.routing_rules
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      priority                   = request_routing_rule.value.priority
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }
  	  lifecycle {
    ignore_changes = [
      ssl_certificate
    ]
  }
}