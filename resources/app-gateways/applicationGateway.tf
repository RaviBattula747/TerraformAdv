module "agw" {
  source = "../../modules/network/apg1"
  apg1   = local.agw
  providers = {
    azurerm = azurerm.management
  }
}

module "agw-prod" {
  source = "../../modules/network/apg1"
  apg1   = local.agw-prod
  providers = {
    azurerm = azurerm.management
  }
}

module "agw-dr" {
  source = "../../modules/network/apg1"
  apg1   = local.agw-dr
  providers = {
    azurerm = azurerm.management
  }
}

module "az-pip-zonal" {
  for_each             = { for k, v in local.pips : k => v }
  source               = "../../modules/network/pipzonal"
  name                 = each.key
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  zones                = each.value.zones
  allocation_method    = "Static"
  sku                  = "Standard"
  ddos_protection_mode = "Disabled"
  providers = {
    azurerm = azurerm.management
  }
}

locals {
  pips = {
    XXXX-d-pip-management-agw-internal-001 = {
      resource_group_name = "XXXX-d-rgp-management-001"
      zones               = ["1", "2", "3"]
      location            = "West Us 3"
    },
    XXXX-d-pip-management-agw-external-001 = {
      resource_group_name = "XXXX-d-rgp-management-001"
      zones               = ["1", "2", "3"]
      location            = "West Us 3"
    },
    XXXX-p-pip-management-agw-internal-001 = {
      resource_group_name = "XXXX-p-rgp-management-001"
      zones               = ["1", "2", "3"]
      location            = "West Us 3"
    },
    XXXX-p-pip-management-agw-external-001 = {
      resource_group_name = "XXXX-p-rgp-management-001"
      zones               = ["1", "2", "3"]
      location            = "West Us 3"
    },
    XXXX-b-pip-management-agw-internal-001 = {
      resource_group_name = "XXXX-b-rgp-management-001-eastus"
      zones               = ["1", "2", "3"]
      location            = "East Us"
    },
    XXXX-b-pip-management-agw-external-001 = {
      resource_group_name = "XXXX-b-rgp-management-001-eastus"
      zones               = ["1", "2", "3"]
      location            = "East Us"
    }
  }

  #_________________________________________________________________________________________________________________________________________
  #                            Application Gateway variables start from here
  #_________________________________________________________________________________________________________________________________________
  
  agw-prod = {
    #-----------------------------------------------------------------------------------------------------------------------------------------
    #                         prod Internal gateway
    #-----------------------------------------------------------------------------------------------------------------------------------------
    apg3 = {
      name                              = "XXXX-p-agw-management-001-internal"
      resource_group_name               = "XXXX-p-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "WAF_v2"
        tier = "WAF_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-p-pip-management-agw-internal-001"
        private_ip_address   = "XX.XX.8.166"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-int-001"
      }

      backend_pools = [
        {
          name         = "prod_col_sce_com"
          ip_addresses = ["XX.XX.19.4"]
          fqdns        = []
        },
        {
          name         = "prod_mic_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_anv_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg01_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg02_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg03_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg04_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg05_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_wsm_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_wtr_sce_com"
          ip_addresses = ["XX.XX.36.4"]
          fqdns        = []
        },
        {
          name         = "prod_emp_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_sca_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_nar_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_ntx_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_rtc_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpjenkins_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "jenkins_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "adcnexus_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpnexus_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "nexusproxy_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpsonarqube_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_prod_mic_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.mic.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "MICAS"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_col_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.col.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_anv_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.anv.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg01_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg01.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg02_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg02.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg03_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg03.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg04_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg04.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg05_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg05.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_wsm_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.wsm.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_wtr_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.wtr.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "cccwatchtower"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_emp_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.emp.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_sca_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.sca.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_nar_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.nar.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_ntx_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.ntx.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_rtc_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.rtc.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpjenkins_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["iocpjenkins.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_jenkins_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["jenkins.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_adcnexus_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["adcnexus.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpnexus_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["iocpnexus.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_nexusproxy_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["nexusproxy.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpsonarqube_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.application19.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_prod_col_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.col.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_mic_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.mic.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 60
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_anv_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.anv.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg01_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg01.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg02_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg02.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg03_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg03.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg04_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg04.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg05_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg05.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_wsm_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.wsm.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_wtr_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.wtr.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_emp_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.emp.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_sca_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.sca.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_nar_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.nar.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_ntx_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.ntx.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_rtc_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.rtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpjenkins_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "iocpjenkins.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_jenkins_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "jenkins.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_adcnexus_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "adcnexus.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpnexus_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "iocpnexus.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_nexusproxy_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "nexusproxy.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpsonarqube_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.application19.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_prod_mic_sce_com"
          rule_type                   = "Basic"
          priority                    = 5
          http_listener_name          = "lis_tcp_443_prod_mic_sce_com"
          backend_address_pool_name   = "prod_mic_sce_com"
          backend_http_settings_name  = "http_443_prod_mic_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_col_sce_com"
          rule_type                   = "Basic"
          priority                    = 34
          http_listener_name          = "lis_tcp_443_prod_col_sce_com"
          backend_address_pool_name   = "prod_col_sce_com"
          backend_http_settings_name  = "http_443_prod_col_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_anv_sce_com"
          rule_type                   = "Basic"
          priority                    = 33
          http_listener_name          = "lis_tcp_443_prod_anv_sce_com"
          backend_address_pool_name   = "prod_anv_sce_com"
          backend_http_settings_name  = "http_443_prod_anv_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg01_sce_com"
          rule_type                   = "Basic"
          priority                    = 40
          http_listener_name          = "lis_tcp_443_prod_apg01_sce_com"
          backend_address_pool_name   = "prod_apg01_sce_com"
          backend_http_settings_name  = "http_443_prod_apg01_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg02_sce_com"
          rule_type                   = "Basic"
          priority                    = 41
          http_listener_name          = "lis_tcp_443_prod_apg02_sce_com"
          backend_address_pool_name   = "prod_apg02_sce_com"
          backend_http_settings_name  = "http_443_prod_apg02_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg03_sce_com"
          rule_type                   = "Basic"
          priority                    = 42
          http_listener_name          = "lis_tcp_443_prod_apg03_sce_com"
          backend_address_pool_name   = "prod_apg03_sce_com"
          backend_http_settings_name  = "http_443_prod_apg03_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg04_sce_com"
          rule_type                   = "Basic"
          priority                    = 43
          http_listener_name          = "lis_tcp_443_prod_apg04_sce_com"
          backend_address_pool_name   = "prod_apg04_sce_com"
          backend_http_settings_name  = "http_443_prod_apg04_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg05_sce_com"
          rule_type                   = "Basic"
          priority                    = 44
          http_listener_name          = "lis_tcp_443_prod_apg05_sce_com"
          backend_address_pool_name   = "prod_apg05_sce_com"
          backend_http_settings_name  = "http_443_prod_apg05_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_wsm_sce_com"
          rule_type                   = "Basic"
          priority                    = 45
          http_listener_name          = "lis_tcp_443_prod_wsm_sce_com"
          backend_address_pool_name   = "prod_wsm_sce_com"
          backend_http_settings_name  = "http_443_prod_wsm_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_wtr_sce_com"
          rule_type                   = "PathBasedRouting"
          priority                    = 46
          http_listener_name          = "lis_tcp_443_prod_wtr_sce_com"
          backend_address_pool_name   = null
          backend_http_settings_name  = null
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = "pbr_prod_wtr_sce_com"
        },
        {
          name                        = "lb_rule_443_prod_emp_sce_com"
          rule_type                   = "Basic"
          priority                    = 47
          http_listener_name          = "lis_tcp_443_prod_emp_sce_com"
          backend_address_pool_name   = "prod_emp_sce_com"
          backend_http_settings_name  = "http_443_prod_emp_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_sca_sce_com"
          rule_type                   = "Basic"
          priority                    = 48
          http_listener_name          = "lis_tcp_443_prod_sca_sce_com"
          backend_address_pool_name   = "prod_sca_sce_com"
          backend_http_settings_name  = "http_443_prod_sca_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_nar_sce_com"
          rule_type                   = "Basic"
          priority                    = 49
          http_listener_name          = "lis_tcp_443_prod_nar_sce_com"
          backend_address_pool_name   = "prod_nar_sce_com"
          backend_http_settings_name  = "http_443_prod_nar_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_ntx_sce_com"
          rule_type                   = "Basic"
          priority                    = 431
          http_listener_name          = "lis_tcp_443_prod_ntx_sce_com"
          backend_address_pool_name   = "prod_ntx_sce_com"
          backend_http_settings_name  = "http_443_prod_ntx_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_rtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 439
          http_listener_name          = "lis_tcp_443_prod_rtc_sce_com"
          backend_address_pool_name   = "prod_rtc_sce_com"
          backend_http_settings_name  = "http_443_prod_rtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpjenkins_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 432
          http_listener_name          = "lis_tcp_443_iocpjenkins_devops_sce_com"
          backend_address_pool_name   = "iocpjenkins_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpjenkins_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_jenkins_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 433
          http_listener_name          = "lis_tcp_443_jenkins_devops_sce_com"
          backend_address_pool_name   = "jenkins_devops_sce_com"
          backend_http_settings_name  = "http_443_jenkins_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_adcnexus_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 434
          http_listener_name          = "lis_tcp_443_adcnexus_devops_sce_com"
          backend_address_pool_name   = "adcnexus_devops_sce_com"
          backend_http_settings_name  = "http_443_adcnexus_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpnexus_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 435
          http_listener_name          = "lis_tcp_443_iocpnexus_devops_sce_com"
          backend_address_pool_name   = "iocpnexus_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpnexus_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_nexusproxy_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 436
          http_listener_name          = "lis_tcp_443_nexusproxy_devops_sce_com"
          backend_address_pool_name   = "nexusproxy_devops_sce_com"
          backend_http_settings_name  = "http_443_nexusproxy_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpsonarqube_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 437
          http_listener_name          = "lis_tcp_443_iocpsonarqube_devops_sce_com"
          backend_address_pool_name   = "iocpsonarqube_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpsonarqube_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = [
        {
          name                               = "pbr_prod_wtr_sce_com"
          default_backend_address_pool_name  = "prod_wtr_sce_com"
          default_backend_http_settings_name = "http_443_prod_wtr_sce_com"
          path_rules = [
            {
              name                       = "prod_wtr_sce_com"
              paths                      = ["/prod.wtr.sce.com"]
              backend_address_pool_name  = "prod_wtr_sce_com"
              backend_http_settings_name = "http_443_prod_wtr_sce_com"
            }
          ]
        }
      ]
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-int-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "Middleware"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Middleware"
        },
        {
          name                = "MICAS"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/MICAS"
        },
        {
          name                = "cccwatchtower"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/CCCwatchtower"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }

    #======================================================================================================================================
    #                         Prod External Gateway
    #======================================================================================================================================
    apg4 = {
      name                              = "XXXX-p-agw-management-001-external"
      resource_group_name               = "XXXX-p-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-p-pip-management-agw-external-001"
        private_ip_address   = "XX.XX.8.196"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-ext-001"
      }

      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "ccacwtc.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-ext-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        },
        {
          name                = "ccacwtc.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/ccacwrtc-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }

  }

  agw-dr = {
    #======================================================================================================================================
    #                         East US Prod Internal Gateway
    #======================================================================================================================================
    apg5 = {
      name                              = "XXXX-b-agw-management-001-internal"
      resource_group_name               = "XXXX-b-rgp-management-001-eastus"
      location                          = "East US"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/publicIPAddresses/XXXX-b-pip-management-agw-internal-001"
        private_ip_address   = "10.133.8.136"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-int-001"
      }

      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = false
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-int-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }
    #======================================================================================================================================
    #                         East US Prod External Gateway
    #======================================================================================================================================
    apg6 = {
      name                              = "XXXX-b-agw-management-001-external"
      resource_group_name               = "XXXX-b-rgp-management-001-eastus"
      location                          = "East US"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/publicIPAddresses/XXXX-b-pip-management-agw-external-001"
        private_ip_address   = "10.133.8.164"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-ext-001"
      }
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-ext-001"
        }
      ]
      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = false
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }
  }

  agw = {
    #-----------------------------------------------------------------------------------------------------------------------------------------
    #                         Non - prod Internal gateway
    #-----------------------------------------------------------------------------------------------------------------------------------------
    apg1 = {
      name                              = "XXXX-d-agw-management-001-internal"
      resource_group_name               = "XXXX-d-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/XXXX_cma_waf_policy"
      force_firewall_policy_association = true
      zones                             = ["1", "2"]
      sku = {
        name = "WAF_v2"
        tier = "WAF_v2"
        #capacity = 2
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-d-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-d-pip-management-agw-internal-001"
        private_ip_address   = "XX.XX.8.16"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-001"
      }

      backend_pools = [
        {
          name         = "dev_wtr_sce_com"
          ip_addresses = ["XX.XX.22.4"]
          fqdns        = []
        },
        {
          name         = "adcsjenkins_devops_sce_com"
          ip_addresses = ["XX.XX.32.101"]
          fqdns        = []
        },
        {
          name         = "jenkinsdevtest_devops_sce_com"
          ip_addresses = ["XX.XX.32.77"]
          fqdns        = []
        },
        {
          name         = "nexusdevtest_devops_sce_com"
          ip_addresses = ["XX.XX.21.71"]
          fqdns        = []
        },
        {
          name         = "adcssonarqube_devops_sce_com"
          ip_addresses = ["XX.XX.24.69"]
          fqdns        = []
        },
        {
          name         = "dev_col_sce_com"
          ip_addresses = ["XX.XX.19.196"]
          fqdns        = []
        },
        {
          name         = "dev_apg_sce_com"
          ip_addresses = ["XX.XX.17.68"]
          fqdns        = []
        },
        {
          name         = "qa_apg01_sce_com"
          ip_addresses = ["XX.XX.17.198"]
          fqdns        = []
        },
        {
          name         = "qa_apg02_sce_com"
          ip_addresses = ["XX.XX.17.196"]
          fqdns        = []
        },
        {
          name         = "qa_apg03_sce_com"
          ip_addresses = ["XX.XX.17.197"]
          fqdns        = []
        },
        {
          name         = "qa_apg04_sce_com"
          ip_addresses = ["XX.XX.17.200"]
          fqdns        = []
        },
        {
          name         = "qa_apg05_sce_com"
          ip_addresses = ["XX.XX.17.199"]
          fqdns        = []
        },
        {
          name         = "dev_tdm_sce_com"
          ip_addresses = ["XX.XX.29.196"]
          fqdns        = []
        },
        {
          name         = "wsm_sce_com"
          ip_addresses = ["XX.XX.25.196"]
          fqdns        = []
        },
        {
          name         = "dev_emp_sce_com"
          ip_addresses = ["XX.XX.22.4"]
          fqdns        = []
        },
        {
          name         = "dev_anv_sce_com"
          ip_addresses = ["XX.XX.16.196"]
          fqdns        = []
        },
        {
          name         = "oweliut_sce_com"
          ip_addresses = ["XX.XX.30.100"]
          fqdns        = []
        },
        {
          name         = "voltut_sce_com"
          ip_addresses = ["XX.XX.30.100"]
          fqdns        = []
        },
        {
          name         = "owelist_sce_com"
          ip_addresses = ["XX.XX.30.229", "XX.XX.30.228"]
          fqdns        = []
        },
        {
          name         = "voltst_sce_com"
          ip_addresses = ["XX.XX.30.229", "XX.XX.30.228"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "aewcsasg01-fnd-port-443"
          port = 80
        },
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_dev_anv_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.anv.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "ActiveNavigation"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_dev_emp_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.emp.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "eDMRMMigrationPlanner"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_dev_wtr_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.wtr.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "CCCwatchtower"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_wsm_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["wsm.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Winshuttle"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_qa_apg01_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["qa.apg01.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "AdobeQA"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_qa_apg02_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["qa.apg02.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "AdobeQA"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_qa_apg03_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["qa.apg03.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "AdobeQA"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_qa_apg04_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["qa.apg04.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "AdobeQA"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_qa_apg05_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["qa.apg05.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "AdobeQA"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_dev_tdm_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.tdm.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "InfosysEnterpriseDataProtectionSuite"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_dev_apg_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.apg.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Adobe"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_dev_col_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["dev.col.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_adcsnexus_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["adcsnexus.devops.sce.com"]
          require_sni                    = true
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_adcssonarqube_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["adcssonarqube.devops.sce.com"]
          require_sni                    = true
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_nexusdevtest_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["nexusdevtest.devops.sce.com"]
          require_sni                    = true
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_jenkinsdevtest_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["jenkinsdevtest.devops.sce.com"]
          require_sni                    = true
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_adcsjenkins_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["adcsjenkins.devops.sce.com"]
          require_sni                    = true
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_oweliut_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "oweliut.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "oweliut.sce.com"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_voltut_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "voltut.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "oweliut.sce.com"
          ssl_profile_name               = "XXXX-d-ssl-vrs"
        },
        {
          name                           = "lis_tcp_443_owelist_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "owelist.sce.com"
          host_names                     = null
          require_sni                    = false
          ssl_certificate_name           = "owelist"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_voltst_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "voltst.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "owelist"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_nexusdevtest_devops_sce_com"
          port                                = 8081
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_nexusdevtest_devops_sce_com"
          host_name                           = "nexusdevtest.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = []
        },
        {
          name                                = "http_443_jenkinsdevtest_devops_sce_com"
          port                                = 8081
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_jenkinsdevtest_devops_sce_com"
          host_name                           = "jenkinsdevtest.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = []
        },
        {
          name                                = "http_443_adcssonarqube_devops_sce_com"
          port                                = 9000
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_adcssonarqube_devops_sce_com"
          host_name                           = "adcssonarqube.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = []
        },
        {
          name                                = "http_443_adcsnexus_devops_sce_com"
          port                                = 8081
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_adcsnexus_devops_sce_com"
          host_name                           = "adcsnexus.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = []
        },
        {
          name                                = "http_443_adcsjenkins_devops_sce_com"
          port                                = 8080
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_adcsjenkins_devops_sce_com"
          host_name                           = "adcsjenkins.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = []
        },
        {
          name                                = "http_443_dev_tdm_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "mqwuqtdm01.sce.eix.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_dev_col_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "dev.col.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_qa_apg01_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "qa.apg01.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_qa_apg02_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "qa.apg02.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_qa_apg03_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "qa.apg03.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_qa_apg04_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "qa.apg04.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_qa_apg05_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "qa.apg05.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_wsm_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_wsm_sce_com"
          host_name                           = "wsm.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_dev_emp_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "dev.emp.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_dev_wtr_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = "hp_443_dev_wtr_sce_com"
          host_name                           = "dev.wtr.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_dev_apg_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "dev.apg.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_dev_anv_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Enabled"
          affinity_cookie_name                = "ApplicationGatewayAffinity"
          path                                = null
          probe_name                          = "hp_443_dev_anv_sce_com"
          host_name                           = "dev.anv.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_oweliut_sce_com"
          port                                = 4445
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "oweliut.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_voltut_sce_com"
          port                                = 4443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "voltut.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_owelist_sce_com"
          port                                = 4445
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "owelist.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_voltst_sce_com"
          port                                = 4443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "voltst.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_wsm_sce_com"
          rule_type                   = "Basic"
          priority                    = 25
          http_listener_name          = "lis_tcp_443_wsm_sce_com"
          backend_address_pool_name   = "wsm_sce_com"
          backend_http_settings_name  = "http_443_wsm_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_dev_wtr_sce_com"
          rule_type                   = "PathBasedRouting"
          priority                    = 26
          http_listener_name          = "lis_tcp_443_dev_wtr_sce_com"
          backend_address_pool_name   = null
          backend_http_settings_name  = null
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = "url" #module.agw[0].url_path_map[0].name
        },
        {
          name                        = "lb_rule_443_adcsnexus_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 27
          http_listener_name          = "lis_tcp_443_adcsnexus_devops_sce_com"
          backend_address_pool_name   = "adcssonarqube_devops_sce_com"
          backend_http_settings_name  = "http_443_adcsnexus_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rules_443_dev_col_sce_com"
          rule_type                   = "Basic"
          priority                    = 31
          http_listener_name          = "lis_tcp_443_dev_col_sce_com"
          backend_address_pool_name   = "dev_col_sce_com"
          backend_http_settings_name  = "http_443_dev_col_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_dev_emp_sce_com"
          rule_type                   = "PathBasedRouting"
          priority                    = 35
          http_listener_name          = "lis_tcp_443_dev_emp_sce_com"
          backend_address_pool_name   = null
          backend_http_settings_name  = null
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = "pathrule1"
        },
        {
          name                        = "lb_rule_443_dev_anv_sce_com"
          rule_type                   = "Basic"
          priority                    = 161
          http_listener_name          = "lis_tcp_443_dev_anv_sce_com"
          backend_address_pool_name   = "dev_anv_sce_com"
          backend_http_settings_name  = "http_443_dev_anv_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_dev_apg_sce_com"
          rule_type                   = "Basic"
          priority                    = 171
          http_listener_name          = "lis_tcp_443_dev_apg_sce_com"
          backend_address_pool_name   = "dev_apg_sce_com"
          backend_http_settings_name  = "http_443_dev_apg_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_qa_apg01_sce_com"
          rule_type                   = "Basic"
          priority                    = 172
          http_listener_name          = "lis_tcp_443_qa_apg01_sce_com"
          backend_address_pool_name   = "qa_apg01_sce_com"
          backend_http_settings_name  = "http_443_qa_apg01_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_qa_apg02_sce_com"
          rule_type                   = "Basic"
          priority                    = 173
          http_listener_name          = "lis_tcp_443_qa_apg02_sce_com"
          backend_address_pool_name   = "qa_apg02_sce_com"
          backend_http_settings_name  = "http_443_qa_apg02_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_qa_apg03_sce_com"
          rule_type                   = "Basic"
          priority                    = 174
          http_listener_name          = "lis_tcp_443_qa_apg03_sce_com"
          backend_address_pool_name   = "qa_apg03_sce_com"
          backend_http_settings_name  = "http_443_qa_apg03_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_qa_apg04_sce_com"
          rule_type                   = "Basic"
          priority                    = 175
          http_listener_name          = "lis_tcp_443_qa_apg04_sce_com"
          backend_address_pool_name   = "qa_apg04_sce_com"
          backend_http_settings_name  = "http_443_qa_apg04_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_qa_apg05_sce_com"
          rule_type                   = "Basic"
          priority                    = 176
          http_listener_name          = "lis_tcp_443_qa_apg05_sce_com"
          backend_address_pool_name   = "qa_apg05_sce_com"
          backend_http_settings_name  = "http_443_qa_apg05_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_nexusdevtest_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 211
          http_listener_name          = "lis_tcp_443_nexusdevtest_devops_sce_com"
          backend_address_pool_name   = "nexusdevtest_devops_sce_com"
          backend_http_settings_name  = "http_443_nexusdevtest_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_adcssonarqube_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 241
          http_listener_name          = "lis_tcp_443_adcssonarqube_devops_sce_com"
          backend_address_pool_name   = "adcssonarqube_devops_sce_com"
          backend_http_settings_name  = "http_443_adcssonarqube_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_dev_tdm_sce_com"
          rule_type                   = "Basic"
          priority                    = 292
          http_listener_name          = "lis_tcp_443_dev_tdm_sce_com"
          backend_address_pool_name   = "dev_tdm_sce_com"
          backend_http_settings_name  = "http_443_dev_tdm_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_adcsjenkins_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 321
          http_listener_name          = "lis_tcp_443_adcsjenkins_devops_sce_com"
          backend_address_pool_name   = "adcsjenkins_devops_sce_com"
          backend_http_settings_name  = "http_443_adcsjenkins_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_jenkinsdevtest_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 322
          http_listener_name          = "lis_tcp_443_jenkinsdevtest_devops_sce_com"
          backend_address_pool_name   = "jenkinsdevtest_devops_sce_com"
          backend_http_settings_name  = "http_443_jenkinsdevtest_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_oweliut_sce_com"
          rule_type                   = "Basic"
          priority                    = 301
          http_listener_name          = "lis_tcp_443_oweliut_sce_com"
          backend_address_pool_name   = "oweliut_sce_com"
          backend_http_settings_name  = "http_443_oweliut_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_voltut_sce_com"
          rule_type                   = "Basic"
          priority                    = 302
          http_listener_name          = "lis_tcp_443_voltut_sce_com"
          backend_address_pool_name   = "voltut_sce_com"
          backend_http_settings_name  = "http_443_voltut_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_owelist_sce_com"
          rule_type                   = "Basic"
          priority                    = 303
          http_listener_name          = "lis_tcp_443_owelist_sce_com"
          backend_address_pool_name   = "owelist_sce_com"
          backend_http_settings_name  = "http_443_owelist_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_voltst_sce_com"
          rule_type                   = "Basic"
          priority                    = 304
          http_listener_name          = "lis_tcp_443_voltst_sce_com"
          backend_address_pool_name   = "voltst_sce_com"
          backend_http_settings_name  = "http_443_voltst_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = [
        {
          name                               = "url"
          default_backend_address_pool_name  = "dev_wtr_sce_com"
          default_backend_http_settings_name = "http_443_dev_wtr_sce_com"
          path_rules = [
            {
              name                       = "dev_wtr_sce_com"
              paths                      = ["/dev.wtr.sce.com"]
              backend_address_pool_name  = "dev_wtr_sce_com"
              backend_http_settings_name = "http_443_dev_wtr_sce_com"
            }
          ]
        },
        {
          name                               = "pathrule1"
          default_backend_address_pool_name  = "dev_emp_sce_com"
          default_backend_http_settings_name = "http_443_dev_emp_sce_com"
          path_rules = [
            {
              name                       = "dev_emp_sce_com"
              paths                      = ["/dev.emp.sce.com"]
              backend_address_pool_name  = "dev_emp_sce_com"
              backend_http_settings_name = "http_443_dev_emp_sce_com"
            }
          ]
        }
      ]
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "ActiveNavigation"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/ActiveNavigation"
        },
        {
          name                = "Middleware"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Middleware"
        },
        {
          name                = "MICAS"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/MICAS"
        },
        {
          name                = "eDMRMMigrationPlanner"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/eDMRMMigrationPlanner"
        },
        {
          name                = "Winshuttle"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Winshuttle"
        },
        {
          name                = "InfosysEnterpriseDataProtectionSuite"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/InfosysEnterpriseDataProtectionSuite"
        },
        {
          name                = "Adobe"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Adobe"
        },
        {
          name                = "AdobeQA"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Adobe01QA"
        },
        {
          name                = "CCCwatchtower"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/CCCwatchtower"
        },
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        },
        {
          name                = "owelist"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/owelist-np"
        },
        {
          name                = "oweliut.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/oweliut-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_wsm_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "wsm.sce.com"
          protocol                                  = "Https"
          port                                      = 443
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-600"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_nexusdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "nexusdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_dev_wtr_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "dev.wtr.sce.com"
          protocol                                  = "Https"
          port                                      = 443
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-600"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_dev_anv_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "dev.anv.sce.com"
          protocol                                  = "Https"
          port                                      = 443
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_adcssonarqube_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "adcssonarqube.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 9000
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-399"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_adcsnexus_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "adcsnexus.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-600"]
          minimum_servers                           = null
        },
        {
          name                                      = "hp_443_adcsjenkins_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "adcsjenkins.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8080
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }
    #-----------------------------------------------------------------------------------------------------------------------------------------
    #                         Non - prod External gateway
    #-----------------------------------------------------------------------------------------------------------------------------------------
    apg2 = {
      name                              = "XXXX-d-agw-management-001-external"
      resource_group_name               = "XXXX-d-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
      }
      autoscale_configuration = {
        min_capacity = 2    # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = null # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-d-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-d-pip-management-agw-external-001"
        private_ip_address   = "XX.XX.8.136"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-d-sub-management-agw-ext-001"
      }

      backend_pools = [
        {
          name         = "ccacwrtclabexternal_sce_com"
          ip_addresses = ["XX.XX.23.196"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtclabexternal_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtclabexternal.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "ccacwrtclabexternal-sce-com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtclabexternal_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = "ApplicationGatewayAffinity"
          path                                = null
          probe_name                          = "hp_443_ccacwrtclabexternal_sce_com"
          host_name                           = "ccacwrtclabexternal.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = [] #Webrtctinter
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtclabexternal_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtclabexternal_sce_com"
          backend_address_pool_name   = "ccacwrtclabexternal_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtclabexternal_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-d-sub-management-agw-ext-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "ccacwrtclabexternal-sce-com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/ccacwrtclabexternal-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_ccacwrtclabexternal_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "ccacwrtclabexternal.sce.com"
          protocol                                  = "Https"
          port                                      = 443
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-300"]
          minimum_servers                           = null
        }
      ]
    }
/*    #-----------------------------------------------------------------------------------------------------------------------------------------
    #                         prod Internal gateway
    #-----------------------------------------------------------------------------------------------------------------------------------------
    apg3 = {
      name                              = "XXXX-p-agw-management-001-internal"
      resource_group_name               = "XXXX-p-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "WAF_v2"
        tier = "WAF_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-p-pip-management-agw-internal-001"
        private_ip_address   = "XX.XX.8.166"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-int-001"
      }

      backend_pools = [
        {
          name         = "prod_col_sce_com"
          ip_addresses = ["XX.XX.19.4"]
          fqdns        = []
        },
        {
          name         = "prod_mic_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_anv_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg01_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg02_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg03_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg04_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_apg05_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_wsm_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_wtr_sce_com"
          ip_addresses = ["XX.XX.36.4"]
          fqdns        = []
        },
        {
          name         = "prod_emp_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_sca_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_nar_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_ntx_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "prod_rtc_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpjenkins_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "jenkins_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "adcnexus_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpnexus_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "nexusproxy_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        },
        {
          name         = "iocpsonarqube_devops_sce_com"
          ip_addresses = ["XX.XX.35.5"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_prod_mic_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.mic.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "MICAS"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_col_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.col.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_anv_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.anv.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg01_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg01.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg02_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg02.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg03_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg03.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg04_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg04.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_apg05_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.apg05.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_wsm_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.wsm.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_wtr_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.wtr.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "cccwatchtower"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_emp_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.emp.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_sca_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.sca.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_nar_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.nar.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_ntx_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.ntx.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_prod_rtc_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.rtc.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpjenkins_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["iocpjenkins.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_jenkins_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["jenkins.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_adcnexus_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["adcnexus.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpnexus_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["iocpnexus.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_nexusproxy_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["nexusproxy.devops.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        },
        {
          name                           = "lis_tcp_443_iocpsonarqube_devops_sce_com"
          frontend_ip_configuration_name = "private"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = null
          host_names                     = ["prod.application19.sce.com"]
          require_sni                    = false
          ssl_certificate_name           = "Middleware"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_prod_col_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.col.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 20
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_mic_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.mic.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 60
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_anv_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.anv.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg01_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg01.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg02_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg02.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg03_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg03.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg04_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg04.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_apg05_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.apg05.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_wsm_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.wsm.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_wtr_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.wtr.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_emp_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.emp.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_sca_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.sca.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_nar_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.nar.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_ntx_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.ntx.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_prod_rtc_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.rtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpjenkins_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "iocpjenkins.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_jenkins_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "jenkins.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_adcnexus_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "adcnexus.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpnexus_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "iocpnexus.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_nexusproxy_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "nexusproxy.devops.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        },
        {
          name                                = "http_443_iocpsonarqube_devops_sce_com"
          port                                = 8443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "prod.application19.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = ["commonRootCertificate"]
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_prod_mic_sce_com"
          rule_type                   = "Basic"
          priority                    = 5
          http_listener_name          = "lis_tcp_443_prod_mic_sce_com"
          backend_address_pool_name   = "prod_mic_sce_com"
          backend_http_settings_name  = "http_443_prod_mic_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_col_sce_com"
          rule_type                   = "Basic"
          priority                    = 34
          http_listener_name          = "lis_tcp_443_prod_col_sce_com"
          backend_address_pool_name   = "prod_col_sce_com"
          backend_http_settings_name  = "http_443_prod_col_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_anv_sce_com"
          rule_type                   = "Basic"
          priority                    = 33
          http_listener_name          = "lis_tcp_443_prod_anv_sce_com"
          backend_address_pool_name   = "prod_anv_sce_com"
          backend_http_settings_name  = "http_443_prod_anv_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg01_sce_com"
          rule_type                   = "Basic"
          priority                    = 40
          http_listener_name          = "lis_tcp_443_prod_apg01_sce_com"
          backend_address_pool_name   = "prod_apg01_sce_com"
          backend_http_settings_name  = "http_443_prod_apg01_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg02_sce_com"
          rule_type                   = "Basic"
          priority                    = 41
          http_listener_name          = "lis_tcp_443_prod_apg02_sce_com"
          backend_address_pool_name   = "prod_apg02_sce_com"
          backend_http_settings_name  = "http_443_prod_apg02_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg03_sce_com"
          rule_type                   = "Basic"
          priority                    = 42
          http_listener_name          = "lis_tcp_443_prod_apg03_sce_com"
          backend_address_pool_name   = "prod_apg03_sce_com"
          backend_http_settings_name  = "http_443_prod_apg03_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg04_sce_com"
          rule_type                   = "Basic"
          priority                    = 43
          http_listener_name          = "lis_tcp_443_prod_apg04_sce_com"
          backend_address_pool_name   = "prod_apg04_sce_com"
          backend_http_settings_name  = "http_443_prod_apg04_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_apg05_sce_com"
          rule_type                   = "Basic"
          priority                    = 44
          http_listener_name          = "lis_tcp_443_prod_apg05_sce_com"
          backend_address_pool_name   = "prod_apg05_sce_com"
          backend_http_settings_name  = "http_443_prod_apg05_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_wsm_sce_com"
          rule_type                   = "Basic"
          priority                    = 45
          http_listener_name          = "lis_tcp_443_prod_wsm_sce_com"
          backend_address_pool_name   = "prod_wsm_sce_com"
          backend_http_settings_name  = "http_443_prod_wsm_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_wtr_sce_com"
          rule_type                   = "PathBasedRouting"
          priority                    = 46
          http_listener_name          = "lis_tcp_443_prod_wtr_sce_com"
          backend_address_pool_name   = null
          backend_http_settings_name  = null
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = "pbr_prod_wtr_sce_com"
        },
        {
          name                        = "lb_rule_443_prod_emp_sce_com"
          rule_type                   = "Basic"
          priority                    = 47
          http_listener_name          = "lis_tcp_443_prod_emp_sce_com"
          backend_address_pool_name   = "prod_emp_sce_com"
          backend_http_settings_name  = "http_443_prod_emp_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_sca_sce_com"
          rule_type                   = "Basic"
          priority                    = 48
          http_listener_name          = "lis_tcp_443_prod_sca_sce_com"
          backend_address_pool_name   = "prod_sca_sce_com"
          backend_http_settings_name  = "http_443_prod_sca_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_nar_sce_com"
          rule_type                   = "Basic"
          priority                    = 49
          http_listener_name          = "lis_tcp_443_prod_nar_sce_com"
          backend_address_pool_name   = "prod_nar_sce_com"
          backend_http_settings_name  = "http_443_prod_nar_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_ntx_sce_com"
          rule_type                   = "Basic"
          priority                    = 431
          http_listener_name          = "lis_tcp_443_prod_ntx_sce_com"
          backend_address_pool_name   = "prod_ntx_sce_com"
          backend_http_settings_name  = "http_443_prod_ntx_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_prod_rtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 439
          http_listener_name          = "lis_tcp_443_prod_rtc_sce_com"
          backend_address_pool_name   = "prod_rtc_sce_com"
          backend_http_settings_name  = "http_443_prod_rtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpjenkins_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 432
          http_listener_name          = "lis_tcp_443_iocpjenkins_devops_sce_com"
          backend_address_pool_name   = "iocpjenkins_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpjenkins_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_jenkins_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 433
          http_listener_name          = "lis_tcp_443_jenkins_devops_sce_com"
          backend_address_pool_name   = "jenkins_devops_sce_com"
          backend_http_settings_name  = "http_443_jenkins_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_adcnexus_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 434
          http_listener_name          = "lis_tcp_443_adcnexus_devops_sce_com"
          backend_address_pool_name   = "adcnexus_devops_sce_com"
          backend_http_settings_name  = "http_443_adcnexus_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpnexus_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 435
          http_listener_name          = "lis_tcp_443_iocpnexus_devops_sce_com"
          backend_address_pool_name   = "iocpnexus_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpnexus_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_nexusproxy_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 436
          http_listener_name          = "lis_tcp_443_nexusproxy_devops_sce_com"
          backend_address_pool_name   = "nexusproxy_devops_sce_com"
          backend_http_settings_name  = "http_443_nexusproxy_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        },
        {
          name                        = "lb_rule_443_iocpsonarqube_devops_sce_com"
          rule_type                   = "Basic"
          priority                    = 437
          http_listener_name          = "lis_tcp_443_iocpsonarqube_devops_sce_com"
          backend_address_pool_name   = "iocpsonarqube_devops_sce_com"
          backend_http_settings_name  = "http_443_iocpsonarqube_devops_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = [
        {
          name                               = "pbr_prod_wtr_sce_com"
          default_backend_address_pool_name  = "prod_wtr_sce_com"
          default_backend_http_settings_name = "http_443_prod_wtr_sce_com"
          path_rules = [
            {
              name                       = "prod_wtr_sce_com"
              paths                      = ["/prod.wtr.sce.com"]
              backend_address_pool_name  = "prod_wtr_sce_com"
              backend_http_settings_name = "http_443_prod_wtr_sce_com"
            }
          ]
        }
      ]
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-int-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "Middleware"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/Middleware"
        },
        {
          name                = "MICAS"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/MICAS"
        },
        {
          name                = "cccwatchtower"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/CCCwatchtower"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }

    #======================================================================================================================================
    #                         Prod External Gateway
    #======================================================================================================================================
    apg4 = {
      name                              = "XXXX-p-agw-management-001-external"
      resource_group_name               = "XXXX-p-rgp-management-001"
      location                          = "West US 3"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/publicIPAddresses/XXXX-p-pip-management-agw-external-001"
        private_ip_address   = "XX.XX.8.196"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-ext-001"
      }

      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = true
          ssl_certificate_name           = "ccacwtc.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/XXXX-p-vnt-management-001/subnets/XXXX-p-sub-management-agw-ext-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        },
        {
          name                = "ccacwtc.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/ccacwrtc-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }*/
/*    #======================================================================================================================================
    #                         East US Prod Internal Gateway
    #======================================================================================================================================
    apg5 = {
      name                              = "XXXX-b-agw-management-001-internal"
      resource_group_name               = "XXXX-b-rgp-management-001-eastus"
      location                          = "East US"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/publicIPAddresses/XXXX-b-pip-management-agw-internal-001"
        private_ip_address   = "10.133.8.136"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-int-001"
      }

      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = false
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-int-001"
        }
      ]
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }
    #======================================================================================================================================
    #                         East US Prod External Gateway
    #======================================================================================================================================
    apg6 = {
      name                              = "XXXX-b-agw-management-001-external"
      resource_group_name               = "XXXX-b-rgp-management-001-eastus"
      location                          = "East US"
      firewall_policy_id                = null
      force_firewall_policy_association = null
      zones                             = ["1", "2"]
      sku = {
        name = "Standard_v2"
        tier = "Standard_v2"
        #capacity = null
      }
      autoscale_configuration = {
        min_capacity = 2  # - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
        max_capacity = 10 # - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
      }
      frontend_ip_configurations = {
        name                 = "private"
        public_ip_address_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/publicIPAddresses/XXXX-b-pip-management-agw-external-001"
        private_ip_address   = "10.133.8.164"
        subnet_id            = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-ext-001"
      }
      gateway_ip_configurations = [
        {
          name      = "appGatewayIpConfig1"
          subnet_id = "/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/XXXX-b-vnt-management-001/subnets/XXXX-b-sub-management-agw-ext-001"
        }
      ]
      backend_pools = [
        {
          name         = "ccacwrtc_sce_com"
          ip_addresses = ["XX.XX.19.68"]
          fqdns        = []
        }
      ]
      frontend_ports = [
        {
          name = "fnd-port-443"
          port = 443
        }
      ]
      http_listeners = [
        {
          name                           = "lis_tcp_443_ccacwrtc_sce_com"
          frontend_ip_configuration_name = "public"
          frontend_port_name             = "fnd-port-443"
          protocol                       = "Https"
          host_name                      = "ccacwrtc.sce.com"
          host_names                     = null
          require_sni                    = false
          ssl_certificate_name           = "devops.sce.com"
          ssl_profile_name               = null
        }
      ]
      backend_http_settings = [
        {
          name                                = "http_443_ccacwrtc_sce_com"
          port                                = 443
          protocol                            = "Https"
          cookie_based_affinity               = "Disabled"
          affinity_cookie_name                = null
          path                                = null
          probe_name                          = null
          host_name                           = "ccacwrtc.sce.com" #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true
          pick_host_name_from_backend_address = false
          request_timeout                     = 30
          trusted_root_certificate_names      = []
        }
      ]
      routing_rules = [
        {
          name                        = "lb_rule_443_ccacwrtc_sce_com"
          rule_type                   = "Basic"
          priority                    = 7
          http_listener_name          = "lis_tcp_443_ccacwrtc_sce_com"
          backend_address_pool_name   = "ccacwrtc_sce_com"
          backend_http_settings_name  = "http_443_ccacwrtc_sce_com"
          redirect_configuration_name = null
          rewrite_rule_set_name       = null
          url_path_map_name           = null
        }
      ]
      url_path_map = []
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/XXXX.xxxxxxxxxxxxxxx.xxxxxxxxxxxxxxx.xxxxxxxxxxx/resourceGroups/XXXX-p-rgp-management-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/XXXX-p-umi-policy-001"]
      }
      ssl_certificate = [
        {
          name                = "devops.sce.com"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/devops-sce-com"
        }
      ]
      trusted_root_certificate = [
        {
          name                = "commonRootCertificate"
          key_vault_secret_id = "https://XXXX-p-key-management.vault.azure.net/secrets/commonRootCertificate"
        }
      ]
      probe = [
        {
          name                                      = "hp_443_jenkinsdevtest_devops_sce_com"
          pick_host_name_from_backend_http_settings = false
          host                                      = "jenkinsdevtest.devops.sce.com"
          protocol                                  = "Https"
          port                                      = 8081
          path                                      = "/"
          interval                                  = 30
          timeout                                   = 30
          unhealthy_threshold                       = 3
          body                                      = null
          status_code                               = ["200-500"]
          minimum_servers                           = null
        }
      ]
    }*/
  }
}