variable "apg1" {
  description = "Configuration for the Application Gateways."
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    firewall_policy_id                = string
    force_firewall_policy_association = bool
    zones                         = list(string)
    identity                      = object({
        type = string
        identity_ids = list(string)
    })
    sku                           = object({
      name     = string
      tier     = string
      #capacity = number
    })
    autoscale_configuration = object({
        min_capacity = number
        max_capacity = number
    })
    frontend_ip_configurations    = object({
      name                 = string
      public_ip_address_id = string
      private_ip_address   = string
      subnet_id            = string
    })
    backend_pools                 = list(object({
      name          = string
      ip_addresses  = list(string)
      fqdns         = list(string) # Optional
    }))
    frontend_ports                = list(object({
      name = string
      port = number
    }))
    http_listeners                = list(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
      host_name                      = string
      host_names                     = list(string)
      require_sni                    = bool
      ssl_certificate_name           = string
      ssl_profile_name               = string
    }))
    backend_http_settings         = list(object({
      name                     = string
      port                     = number
      protocol                 = string
      cookie_based_affinity    = string
      affinity_cookie_name  = string
      path                  = string
      probe_name            = string
      host_name             = string
      pick_host_name_from_backend_address = bool
      request_timeout                     = number
      trusted_root_certificate_names      = list(string)
      #authentication_certificate_name     = string
      /*connection_draining    = object({
        enabled     = bool
        drain_timeout_sec = number
      })*/
    }))
    routing_rules                = list(object({
      name                       = string
      rule_type                  = string
      priority                   = number
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
      redirect_configuration_name= string
      rewrite_rule_set_name      = string
      url_path_map_name          = string
    }))
    probe = list(object({
            name = string
            pick_host_name_from_backend_http_settings = bool
            host = string
            protocol = string
            port = number
            path = string
            interval = number
            timeout = number
            unhealthy_threshold = number
              body = string
              status_code = list(string)
            minimum_servers = number
          }))
    url_path_map = list(object({
        name = string
        default_backend_address_pool_name = string
        default_backend_http_settings_name = string
        path_rules = list(object({
          name = string
          paths = list(string)
          backend_address_pool_name = string
          backend_http_settings_name = string
        }))
      }))
    gateway_ip_configurations    = list(object({
      name      = string
      subnet_id = string
    }))
    ssl_certificate = list(object({
        name   = string
        key_vault_secret_id = string
      }))
      
    trusted_root_certificate = list(object({
        name   = string
        key_vault_secret_id = string
    }))
  }))
}