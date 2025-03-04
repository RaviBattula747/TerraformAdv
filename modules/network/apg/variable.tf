variable "apg" {
  description = "Configuration for the Application Gateways."
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    sku                           = object({
      name     = string
      tier     = string
      capacity = number
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
      # fqdns         = list(string) # Optional
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
      /*
      host_name                      = string
      host_names                     = list(string)
      ssl_certificate_name           = string
      */

    }))
    backend_http_settings         = list(object({
      name                     = string
      port                     = number
      protocol                 = string
      cookie_based_affinity    = string
    }))
    routing_rules                = list(object({
      name                       = string
      rule_type                  = string
      priority                   = number
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string

    }))
    gateway_ip_configurations    = list(object({
      name      = string
      subnet_id = string
    }))
  }))
}



/*variable "name" {
  description = "The name of the application gateway."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The location where the resource group is located."
  type        = string
}
variable "sku" {
  description = "The SKU configuration for the application gateway."
  type = object({
    name     = string
    tier     = string
    capacity = number
  })
}
variable "frontend_ip_configurations" {
  description = "The frontend IP configurations for the application gateway."
  type = list(object({
    name                 = string
    public_ip_address_id = optional(string)
    private_ip_address   = optional(string)
    subnet_id            = optional(string)
  }))
}
variable "frontend_ports" {
  description = "The frontend ports for the application gateway."
  type = list(object({
    name     = string
    port     = number
  }))
}
variable "http_listeners" {
  description = "The HTTP listeners for the application gateway."
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
}
variable "backend_http_settings" {
  description = "The backend HTTP settings for the application gateway."
  type = list(object({
    name                     = string
    port                     = number
    protocol                 = string
    cookie_based_affinity    = string
  }))
}
variable "routing_rules" {
  description = "The routing rules for the application gateway."
  type = list(object({
    name                      = string
    rule_type                 = string
    http_listener_name        = string
    backend_address_pool_name = string
    backend_http_settings_name = string
  }))
}
variable "gateway_ip_configurations" {
  description = "The gateway IP configurations for the application gateway."
  type = list(object({
    name      = string
    subnet_id = string
  }))
}
variable "backend_pools" {
  description = "The backend address pools for the application gateway."
  type = list(object({
    name                = string
    ip_addresses = list(string)
   # fqdns       = optional(string)
  }))
}*/
