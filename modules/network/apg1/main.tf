resource "azurerm_application_gateway" "az-apg1" {
 for_each = var.apg1
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  firewall_policy_id                = each.value.firewall_policy_id
  force_firewall_policy_association = each.value.force_firewall_policy_association
  zones                = each.value.zones
  identity {
  type = each.value.identity.type
  identity_ids = each.value.identity.identity_ids
  }
  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
  }
    autoscale_configuration {
        min_capacity = each.value.autoscale_configuration.min_capacity    # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = each.value.autoscale_configuration.max_capacity   # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
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
    name                 = "public"
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
      host_name                      = http_listener.value.host_name
      host_names                     = http_listener.value.host_names
      require_sni                    = http_listener.value.require_sni
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      ssl_profile_name               = http_listener.value.ssl_profile_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_pools
    content {
      name = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses
      fqdns        = backend_address_pool.value.fqdns
      }
    }
  

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings
    content {
      name                    = backend_http_settings.value.name
      port                    = backend_http_settings.value.port
      protocol                = backend_http_settings.value.protocol
      cookie_based_affinity   = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name  = backend_http_settings.value.affinity_cookie_name
      path                  = backend_http_settings.value.path
      probe_name            = backend_http_settings.value.probe_name
      host_name             = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      request_timeout                     = backend_http_settings.value.request_timeout
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names
      /*authentication_certificate          = {
        name = backend_http_settings.value.authentication_certificate_name
        }
      connection_draining    = {
        enabled     = backend_http_settings.value.connection_draining.enabled
        drain_timeout_sec = backend_http_settings.value.connection_draining.drain_timeout_sec
      }*/
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
      redirect_configuration_name= request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name      = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name          = request_routing_rule.value.url_path_map_name
    }
  }
  dynamic "ssl_certificate" {
    for_each = each.value.ssl_certificate
      content {
          name   = ssl_certificate.value.name
          key_vault_secret_id = ssl_certificate.value.key_vault_secret_id
          }
  }
  dynamic "trusted_root_certificate" {
    for_each = each.value.trusted_root_certificate
      content  {
          name                = trusted_root_certificate.value.name
          key_vault_secret_id = trusted_root_certificate.value.key_vault_secret_id
        }
  }
  dynamic "url_path_map" {
      for_each = each.value.url_path_map
      content {
        name = url_path_map.value.name
        default_backend_address_pool_name = url_path_map.value.default_backend_address_pool_name
        default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name
        dynamic "path_rule" {
          for_each = url_path_map.value.path_rules
          content {
            name = path_rule.value.name 
            paths = path_rule.value.paths
            backend_address_pool_name = path_rule.value.backend_address_pool_name
            backend_http_settings_name = path_rule.value.backend_http_settings_name
          }
        }
      }
  }
  dynamic "probe" {
    for_each = each.value.probe
      content {
            name = probe.value.name
            pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
            host = probe.value.host
            protocol = probe.value.protocol
            port = probe.value.port
            path = probe.value.path
            interval = probe.value.interval
            timeout = probe.value.timeout
            unhealthy_threshold = probe.value.unhealthy_threshold
            match {
                body = probe.value.body
                status_code = probe.value.status_code
            }
            minimum_servers = probe.value.minimum_servers
          }
  }
  /*
    dynamic "trusted_root_certificate_name" {
    for_each = each.value.trusted_root_certificate_name
      content {
          name   = trusted_root_certificate_names.value.name
          data   = trusted_root_certificate_names.value.data
          }
    }*/

  	  lifecycle {
    ignore_changes = [ tags, waf_configuration, ssl_profile, trusted_client_certificate
    ]
  } #each.value.backend_http_settings.trusted_root_certificate_names
}

#backend_address_pool, http_listener,frontend_port, probe, firewall_policy_id, force_firewall_policy_association
#backend_http_settings,url_path_map, request_routing_rule,identity,ssl_certificate,  trusted_root_certificate,