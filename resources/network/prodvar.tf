locals {
  exe = {
    prod  = "prod"
    nprod = "nprod"
    dr    = "dr"
  }
  select = (
    local.exe[terraform.workspace] == "prod" ? local.prod :
    local.exe[terraform.workspace] == "nprod" ? local.nprod : local.dr
    #local.exe[terraform.workspace] == "dr" ? local.dr : {}
  )
  prod = {
    # common important variables
    location = "West US 3"
    env      = "prod"
    vhub_id  = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXX6ffb6e5/resourceGroups/XXXX.m-p-rgp-connectivity-001/providers/Microsoft.Network/virtualHubs/XXXX.m-p-vhb-connectivity-001"
    # platform resource vise variables start from here

    rg = {
      #"rg1" = "sub1"
      "XXXX.m-p-rgp-connectivity-001"  = "XXXX.m-p-sbr-connectivity"
      "XXXX.m-p-rgp-identity-001"      = "XXXX.m-p-sbr-identity"
      "XXXX.m-p-rgp-management-001"    = "XXXX.m-p-sbr-management"
      "XXXX.m-d-rgp-management-001"    = "XXXX.m-p-sbr-management"
      "XXXX.m-p-rgp-automation-001"    = "XXXX.m-p-sbr-automation"
      "XXXX.m-p-rgp-cybersecurity-001" = "XXXX.m-p-sbr-cybersecurity"
      "XXXX.m-p-rgp-monitoring-001"    = "XXXX.m-p-sbr-monitoring"
      "XXXX.m-p-rgp-anv-001"           = "XXXX.m-p-sbr-anv"
      "XXXX.m-p-rgp-col-001"           = "XXXX.m-p-sbr-col"
      "XXXX.m-p-rgp-rtc-001"           = "XXXX.m-p-sbr-rtc"
      "XXXX.m-p-rgp-wsm-001"           = "XXXX.m-p-sbr-wsm"
      "XXXX.m-p-rgp-ntx-001"           = "XXXX.m-p-sbr-ntx"
      "XXXX.m-p-rgp-eng-001"           = "XXXX.m-p-sbr-eng"
      "XXXX.m-p-rgp-tdm-001"           = "XXXX.m-p-sbr-tdm"
      "XXXX.m-p-rgp-vrs-001"           = "XXXX.m-p-sbr-vrs"
      "XXXX.m-p-rgp-isr-001"           = "XXXX.m-p-sbr-isr"
    }

    vwan = {
      name                = "XXXX.m-p-vwn-connectivity"
      resource_group_name = "XXXX.m-p-rgp-connectivity-001"
    }

    vhub = {
      name                = "XXXX.m-p-vhb-connectivity-001"
      resource_group_name = "XXXX.m-p-rgp-connectivity-001"
      address_prefix      = "10.130.0.0/23"
      vwan_id             = "/subscriptions/5d8XXXXXXXXXXXXXXXXXXffb6e5/resourceGroups/XXXX.m-p-rgp-connectivity-001/providers/Microsoft.Network/virtualWans/XXXX.m-p-vwn-connectivity"
    }

    hubpeers = [
      "XXXX.m-p-vnt-connectivity-001", "XXXX.m-p-vnt-identity-001", "XXXX.m-p-vnt-automation-001", "XXXX.m-p-vnt-cybersecurity-001",
      "XXXX.m-p-vnt-management-001", "XXXX.m-p-vnt-monitoring-001", "XXXX.m-p-vnt-anv-001", "XXXX.m-p-vnt-col-001", "XXXX.m-p-vnt-rtc-001",
      "XXXX.m-p-vnt-sca-001", "XXXX.m-p-vnt-wsm-001", "XXXX.m-p-vnt-ntx-001", "XXXX.m-p-vnt-eng-001", "XXXX.m-p-vnt-tdm-001", "XXXX.m-p-vnt-vrs-001", "XXXX.m-p-vnt-isr-001"

    ]

    fw = {
      "fw1" = "XXXX.m-p-cfw-elz-001-westus3pa"
    }
    panoramastack = {
      "XXXX.m-p-cfw-elz-001-westus3" = {
        panorama_base64_config       = "eyJkZ25hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXLXRzLXdlc3R1czMiLCAicGFub3JhbWEtc2VydmVyIjogIjEwLjEyOS4xNC4xNDAiLCAiY2duYW1lIjogIk9wcy1Db2xsZWN0b3JzIiwgInBhbm9yYW1hLXNlcnZlci0yIjogIjEwLjEyOS43OS4xNDAiLCAidm0tc2VyaWVzLWF1dG8tcmVnaXN0cmF0aW9uLXBpbi1pZCI6ICI0NTA1ZDc1NC1jYzEwLTQzYTctODNiYy1iYzhlZmExMjQ4NDYiLCAidm0tc2VyaWVzLWF1dG8tcmVnaXN0cmF0aW9uLXBpbi12YWx1ZSI6ICI1ZTlhZGM0ZjQwYTc0YTFlYTY4MTliNjZiNWFhOTQwNyIsICJ2bS1hdXRoLWtleSI6ICI2MjY3MjM0NzA2Njk4OTYiLCAiZXhwaXJ5IjogIjIwMjUvMTAvMDIifQ=="
        resource_group_name          = "XXXX.m-p-rgp-connectivity-001"
        network_virtual_appliance_id = "fw1"
        public_ip_address_ids        = ["/subscriptions/5d847Xb6e5/resourceGroups/XXXX.m-p-rgp-connectivity-001/providers/Microsoft.Network/publicIPAddresses/XXXX.m-p-pip-connectivity-001-cngfw"]
        trusted_address_ranges       = ["155.13.0.0/16", "163.236.0.0/16", "192.212.0.0/15", "192.214.0.0/18", "192.214.64.0/19", "192.214.96.0/24"]
      }
    }

    rtintent = {}

    pips = {
      #pip name     = Rg name
      "XXXX.m-p-pip-connectivity-001-cngfw" = "XXXX.m-p-rgp-connectivity-001"
      "XXXX.m-p-pip-management-001-bastion" = "XXXX.m-p-rgp-management-001"
      "XXXX.m-p-pip-management-001-apgtw"   = "XXXX.m-p-rgp-management-001"
      #"XXXX.m-p-pip-management-002-apgtw"  = "XXXX.m-p-rgp-management-001"
      #"XXXX.m-p-pip-management-001-agw" = "XXXX.m-p-rgp-management-001"  
      "XXXX.m-p-pip-management-001-external-agw" = "XXXX.m-p-rgp-management-001"
    }


    erg = {
      name                = "XXXX.m-p-vng-exr-connectivity-01"
      resource_group_name = "XXXX.m-p-rgp-connectivity-001"
      scale_units         = 5
    }

    bst = {
      name                = "XXXX.m-p-bst-management-001"
      resource_group_name = "XXXX.m-p-rgp-management-001"
      scale_units         = 5
      ip_name             = "XXXX.m-p-pip-management-001-bastion"
      subnet_name         = "AzureBastionSubnet"
    }
    apg  = {}
    apg1 = {}

    dpr = {
      name                = "XXXX.m-p-dpr-identity-001"
      resource_group_name = "XXXX.m-p-rgp-identity-001"
      virtual_network_id  = "XXXX.m-p-vnt-identity-001"

      inputendpoint = {
        #name                     = [private_dns_resolver_id,subnet_id]
        "in"                    = ["XXXX.m-p-dpr-identity-001","XXXX.m-p-sub-identity-dprin-001"]
      }
      outputendpoint = {
        #name                           = [private_dns_resolver_id,subnet_id]
        "on-prem-Infoblox-endpoint" = ["XXXX.m-p-dpr-identity-001", "XXXX.m-p-sub-identity-dprout-001"]
      }
      forwardingruleset = {
        #name                                       =   [rg, out_ep_id]
        "XXXX.m-p-frs-identity-001" = ["XXXX.m-p-rgp-identity-001", "on-prem-Infoblox-endpoint"]
      }
      forwardingrule = {
        #vnet_name                      =   [dns_forwarding_ruleset_id, domain_name]
        #"XXXX.m-p-frl-identity-001" = ["XXXX.m-p-frs-identity-001", "."]
        "rule1" = ["XXXX.m-p-frs-identity-001", "XXXX..eix.com."]
        "rule2" = ["XXXX.m-p-frs-identity-001", "edisonconnect.com."]
        "rule3" = ["XXXX.m-p-frs-identity-001", "edison.com."]
        "rule4" = ["XXXX.m-p-frs-identity-001", "wano.org."]
        "rule5" = ["XXXX.m-p-frs-identity-001", "inpo.org."]
        "rule6" = ["XXXX.m-p-frs-identity-001", "zXXXX.t.net."]
        "rule7" = ["XXXX.m-p-frs-identity-001", "z2XXXX.t.net."]
        "rule8" = ["XXXX.m-p-frs-identity-001", "eixt.com."]
        "rule9" = ["XXXX.m-p-frs-identity-001", "z2XXXX..net."]
        "rule10" = ["XXXX.m-p-frs-identity-001", "zXXXX..net."]
        "rule11" = ["XXXX.m-p-frs-identity-001", "southerncaliforniaedison.com."]
        "rule12" = ["XXXX.m-p-frs-identity-001", "edisoninvestor.com."]
        "rule13" = ["XXXX.m-p-frs-identity-001", "songscommunity.com."]
        "rule14" = ["XXXX.m-p-frs-identity-001", "edisoncareers.com."]
        "rule15" = ["XXXX.m-p-frs-identity-001", "appserviceenvironment.net."]
        "rule16" = ["XXXX.m-p-frs-identity-001", "azure-api.net."]
        "rule17" = ["XXXX.m-p-frs-identity-001", "vault.azure.net."]
        "rule18" = ["XXXX.m-p-frs-identity-001", "aws-XXXX..com."]
        "rule19" = ["XXXX.m-p-frs-identity-001", "nXXXX..com."]
        "rule20" = ["XXXX.m-p-frs-identity-001", "XXXX..com."]
        "rule21" = ["XXXX.m-p-frs-identity-001", "myedison.net."]
        "rule22" = ["XXXX.m-p-frs-identity-001", "myedison.com."]
        "rule23" = ["XXXX.m-p-frs-identity-001", "edisonx.com."]
        "rule24" = ["XXXX.m-p-frs-identity-001", "edisonintlt.com."]
        "rule25" = ["XXXX.m-p-frs-identity-001", "edisonintlapps.com."]
        "rule26" = ["XXXX.m-p-frs-identity-001", "edisonintl.com."]
        "rule27" = ["XXXX.m-p-frs-identity-001", "googleapis.com."]
        "rule28" = ["XXXX.m-p-frs-identity-001", "."]
      }
      dpr_virtual_network_link = {
        #vnet_name                      =  dns_forwarding_ruleset_id
        "XXXX.m-p-vnt-connectivity-001"  = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-identity-001"      = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-automation-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-management-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-monitoring-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-cybersecurity-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-anv-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-col-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-rtc-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-wsm-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-ntx-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-eng-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-tdm-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-vrs-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
        "XXXX.m-p-vnt-isr-001"           = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.m-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.m-p-frs-identity-001"
      }
    }

    virtual_network = {

      "XXXX.m-p-vnt-connectivity-001" = {
        address_space       = ["10.130.4.0/24"]
        resource_group_name = "XXXX.m-p-rgp-connectivity-001"
      }
      "XXXX.m-p-vnt-identity-001" = {
        address_space       = ["10.130.10.0/24"]
        resource_group_name = "XXXX.m-p-rgp-identity-001"
      }
      "XXXX.m-p-vnt-management-001" = {
        address_space       = ["10.130.8.0/24"]
        resource_group_name = "XXXX.m-p-rgp-management-001"
      }
      "XXXX.m-p-vnt-automation-001" = {
        address_space       = ["10.130.9.0/24"]
        resource_group_name = "XXXX.m-p-rgp-automation-001"
      }
      "XXXX.m-p-vnt-cybersecurity-001" = {
        address_space       = ["10.130.12.0/24"]
        resource_group_name = "XXXX.m-p-rgp-cybersecurity-001"
      }
      "XXXX.m-p-vnt-monitoring-001" = {
        address_space       = ["10.130.11.0/24"]
        resource_group_name = "XXXX.m-p-rgp-monitoring-001"
      }

      "XXXX.m-p-vnt-anv-001" = {
        address_space       = ["10.130.16.0/26"]
        resource_group_name = "XXXX.m-p-rgp-anv-001"
      }

      "XXXX.m-p-vnt-col-001" = {
        address_space       = ["10.130.19.0/26"]
        resource_group_name = "XXXX.m-p-rgp-col-001"
      }

      "XXXX.m-p-vnt-rtc-001" = {
        address_space       = ["10.130.23.0/26"]
        resource_group_name = "XXXX.m-p-rgp-rtc-001"
      }

      "XXXX.m-p-vnt-wsm-001" = {
        address_space       = ["10.130.25.0/26"]
        resource_group_name = "XXXX.m-p-rgp-wsm-001"
      }

      "XXXX.m-p-vnt-ntx-001" = {
        address_space       = ["10.130.27.0/26"]
        resource_group_name = "XXXX.m-p-rgp-ntx-001"
      }

      "XXXX.m-p-vnt-eng-001" = {
        address_space       = ["10.130.28.0/26"]
        resource_group_name = "XXXX.m-p-rgp-eng-001"
      }

      "XXXX.m-p-vnt-tdm-001" = {
        address_space       = ["10.130.29.0/26"]
        resource_group_name = "XXXX.m-p-rgp-tdm-001"
      }

      "XXXX.m-p-vnt-vrs-001" = {
        address_space       = ["10.130.30.0/26"]
        resource_group_name = "XXXX.m-p-rgp-vrs-001"
      }

      "XXXX.m-p-vnt-isr-001" = {
        address_space       = ["10.130.37.0/26"]
        resource_group_name = "XXXX.m-p-rgp-isr-001"
      }

    }

    subnet = {
      #  addr Prefix = [vnet name,subnet name] 

      "XXXX.m-p-sub-connectivity-pe-001"    = ["XXXX.m-p-vnt-connectivity-001", "10.130.4.240/28"]
      "XXXX.m-p-sub-management-agw-001"     = ["XXXX.m-p-vnt-management-001", "10.130.8.0/26"]
      "XXXX.m-p-sub-management-pe-001"      = ["XXXX.m-p-vnt-management-001", "10.130.8.240/28"]
      "XXXX.m-p-sub-management-agw-ext-001" = ["XXXX.m-p-vnt-management-001", "10.130.8.192/27"]
      "XXXX.m-p-sub-management-agw-int-001" = ["XXXX.m-p-vnt-management-001", "10.130.8.160/27"]
      "XXXX.m-d-sub-management-agw-ext-001" = ["XXXX.m-p-vnt-management-001", "10.130.8.128/27"]
      "XXXX.m-p-sub-automation-pe-001"      = ["XXXX.m-p-vnt-automation-001", "10.130.9.240/28"]
      "XXXX.m-p-sub-identity-dprout-001"    = ["XXXX.m-p-vnt-identity-001", "10.130.10.0/26"]
      "XXXX.m-p-sub-identity-dprin-001"     = ["XXXX.m-p-vnt-identity-001", "10.130.10.64/26"]
      "XXXX.m-p-sub-identity-rodc-001"      = ["XXXX.m-p-vnt-identity-001", "10.130.10.192/27"]
      "XXXX.m-p-sub-identity-pe-001"        = ["XXXX.m-p-vnt-identity-001", "10.130.10.240/28"]
      "XXXX.m-p-sub-monitoring-pe-002"      = ["XXXX.m-p-vnt-monitoring-001", "10.130.11.192/27"]
      "XXXX.m-p-sub-monitoring-pe-001"      = ["XXXX.m-p-vnt-monitoring-001", "10.130.11.240/28"]
      "XXXX.m-p-sub-cybersecurity-pe-001"   = ["XXXX.m-p-vnt-cybersecurity-001", "10.130.12.240/28"]

      "XXXX.m-p-sub-anv-app-001" = ["XXXX.m-p-vnt-anv-001", "10.130.16.0/28"]
      "XXXX.m-p-sub-col-app-001" = ["XXXX.m-p-vnt-col-001", "10.130.19.0/28"]
      "XXXX.m-p-sub-rtc-app-001" = ["XXXX.m-p-vnt-rtc-001", "10.130.23.0/28"]
      "XXXX.m-p-sub-wsm-app-001" = ["XXXX.m-p-vnt-wsm-001", "10.130.25.0/28"]
      "XXXX.m-p-sub-ntx-app-001" = ["XXXX.m-p-vnt-ntx-001", "10.130.27.0/28"]
      "XXXX.m-p-sub-eng-app-001" = ["XXXX.m-p-vnt-eng-001", "10.130.28.0/28"]
      "XXXX.m-p-sub-tdm-app-001" = ["XXXX.m-p-vnt-tdm-001", "10.130.29.0/28"]
      "XXXX.m-p-sub-vrs-app-001" = ["XXXX.m-p-vnt-vrs-001", "10.130.30.0/28"]
      "XXXX.m-p-sub-isr-app-001" = ["XXXX.m-p-vnt-isr-001", "10.130.37.0/27"]
      "XXXX.m-p-sub-isr-app-002" = ["XXXX.m-p-vnt-isr-001", "10.130.37.32/28"]


      "XXXX.m-p-sub-anv-db-001" = ["XXXX.m-p-vnt-anv-001", "10.130.16.16/28"]
      "XXXX.m-p-sub-col-db-001" = ["XXXX.m-p-vnt-col-001", "10.130.19.16/28"]
      "XXXX.m-p-sub-rtc-db-001" = ["XXXX.m-p-vnt-rtc-001", "10.130.23.16/28"]
      "XXXX.m-p-sub-wsm-db-001" = ["XXXX.m-p-vnt-wsm-001", "10.130.25.16/28"]
      "XXXX.m-p-sub-ntx-db-001" = ["XXXX.m-p-vnt-ntx-001", "10.130.27.16/28"]
      "XXXX.m-p-sub-eng-db-001" = ["XXXX.m-p-vnt-eng-001", "10.130.28.16/28"]
      "XXXX.m-p-sub-tdm-db-001" = ["XXXX.m-p-vnt-tdm-001", "10.130.29.16/28"]
      "XXXX.m-p-sub-vrs-db-001" = ["XXXX.m-p-vnt-vrs-001", "10.130.30.16/28"]

      "XXXX.m-p-sub-anv-web-001" = ["XXXX.m-p-vnt-anv-001", "10.130.16.32/28"]
      "XXXX.m-p-sub-col-web-001" = ["XXXX.m-p-vnt-col-001", "10.130.19.32/28"]
      "XXXX.m-p-sub-rtc-web-001" = ["XXXX.m-p-vnt-rtc-001", "10.130.23.32/28"]
      "XXXX.m-p-sub-wsm-web-001" = ["XXXX.m-p-vnt-wsm-001", "10.130.25.32/28"]
      "XXXX.m-p-sub-ntx-web-001" = ["XXXX.m-p-vnt-ntx-001", "10.130.27.32/28"]
      "XXXX.m-p-sub-eng-web-001" = ["XXXX.m-p-vnt-eng-001", "10.130.28.32/28"]
      "XXXX.m-p-sub-tdm-web-001" = ["XXXX.m-p-vnt-tdm-001", "10.130.29.32/28"]
      "XXXX.m-p-sub-vrs-web-001" = ["XXXX.m-p-vnt-vrs-001", "10.130.30.32/28"]

      "XXXX.m-p-sub-anv-pe-001" = ["XXXX.m-p-vnt-anv-001", "10.130.16.48/28"]
      "XXXX.m-p-sub-col-pe-001" = ["XXXX.m-p-vnt-col-001", "10.130.19.48/28"]
      "XXXX.m-p-sub-rtc-pe-001" = ["XXXX.m-p-vnt-rtc-001", "10.130.23.48/28"]
      "XXXX.m-p-sub-wsm-pe-001" = ["XXXX.m-p-vnt-wsm-001", "10.130.25.48/28"]
      "XXXX.m-p-sub-ntx-pe-001" = ["XXXX.m-p-vnt-ntx-001", "10.130.27.48/28"]
      "XXXX.m-p-sub-eng-pe-001" = ["XXXX.m-p-vnt-eng-001", "10.130.28.48/28"]
      "XXXX.m-p-sub-tdm-pe-001" = ["XXXX.m-p-vnt-tdm-001", "10.130.29.48/28"]
      "XXXX.m-p-sub-vrs-pe-001" = ["XXXX.m-p-vnt-vrs-001", "10.130.30.48/28"]
      "XXXX.m-p-sub-isr-pe-001" = ["XXXX.m-p-vnt-isr-001", "10.130.37.48/28"]


    }


    nsg = {
      #  nsg_name = rg name

      "XXXX.m-p-nsg-identity-dprout-001" = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-nsg-identity-dprin-001"  = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-nsg-identity-rodc-001"   = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-nsg-management-agw-001-int" = "XXXX.m-p-rgp-management-001"
      "XXXX.m-p-nsg-management-agw-001-ext" = "XXXX.m-p-rgp-management-001"
      "XXXX.m-d-nsg-management-agw-001-int" = "XXXX.m-d-rgp-management-001"
      "XXXX.m-d-nsg-management-agw-001-ext" = "XXXX.m-d-rgp-management-001"

      "XXXX.m-p-nsg-anv-app-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-nsg-col-app-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-nsg-rtc-app-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-nsg-wsm-app-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-nsg-ntx-app-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-nsg-eng-app-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-nsg-tdm-app-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-nsg-vrs-app-001" = "XXXX.m-p-rgp-vrs-001"
      "XXXX.m-p-nsg-isr-app-001" = "XXXX.m-p-rgp-isr-001"
      "XXXX.m-p-nsg-isr-app-002" = "XXXX.m-p-rgp-isr-001"


      "XXXX.m-p-nsg-anv-db-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-nsg-col-db-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-nsg-rtc-db-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-nsg-wsm-db-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-nsg-ntx-db-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-nsg-eng-db-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-nsg-tdm-db-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-nsg-vrs-db-001" = "XXXX.m-p-rgp-vrs-001"

      "XXXX.m-p-nsg-anv-web-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-nsg-col-web-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-nsg-rtc-web-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-nsg-wsm-web-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-nsg-ntx-web-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-nsg-eng-web-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-nsg-tdm-web-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-nsg-vrs-web-001" = "XXXX.m-p-rgp-vrs-001"


    }

    nsgrule = {

      #                                                    # references to write NSG rules - "key" = [value]
      #                                                    #    example key - "ia0100nsg1" 
      #                                                    #       i    - first letter either be i or o, representing inbound rule or outbound rule
      #                                                    #       a    - second letter either be a or d, representing Allow or Deny
      #                                                    #       0100 - following 4 letters are for priority
      #                                                    #       nsg1 - after that it could the NSG name of any length
      #
      #                                                    #    example value - ["AllowHttpfromSpoke2","Tcp"    , ["80","443"], ["10.6.2.0/24","10.6.1.5"], ["10.6.1.5","10.6.1.6"]]
      #                                                    #                    [rulename             ,protocol, [dest ports], [source address prefixes] , [destination addr prefixes]]    
      #                                                    #                   

      # "ia0100nsg-snet-lbs-01" = ["AllowP2SvpnTraffic", "Tcp", ["3389", "80"], ["10.5.3.64/26"], ["10.5.2.128/26", "10.5.2.192/26"]]
      # "id4096nsg-snet-lbs-01" = ["Deny_All", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.m-p-nsg-identity-dprout-001" = ["XXXX.m-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.m-p-nsg-identity-dprin-001" = ["XXXX.m-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      
      "oa0300XXXX.m-p-nsg-identity-rodc-001" = ["Tcp", ["3389"], ["10.130.10.192/27"], ["172.25.104.19", "172.25.104.20"]]
      "ia0300XXXX.m-p-nsg-identity-rodc-001" = ["Tcp", ["3389"], ["172.25.104.19", "172.25.104.20"], ["10.130.10.192/27"]]
      "ia0300XXXX.m-p-nsg-anv-app-001"       = ["Tcp", ["25"], ["172.25.248.127", "172.25.248.125"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]
      "ia0301XXXX.m-p-nsg-anv-app-001"       = ["*", ["80", "443", "3389"], ["192.212.0.0/15", "172.16.0.0/16", "10.128.0.0/9", "192.168.0.0/16", "155.13.0.0/16", "163.235.0.0/16", "163.236.0.0/16", "192.214.0.0/18"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]
      "ia0302XXXX.m-p-nsg-anv-app-001"       = ["Tcp", ["80", "443", "805"], ["40.108.128.0/17", "13.107.18.10", "13.107.19.10", "52.238.78.88/30", "157.56.240.0/22", "191.232.96.0/23", "191.234.6.152/30", "213.199.180.128/25", "13.107.6.152", "13.107.9.152", "131.253.33.215", "204.79.197.215", "20.190.128.0/18", "40.126.0.0/18", "23.103.160.0/20", "23.103.224.0/19", "40.96.0.0/13", "40.104.0.0/15", "132.245.0.0/16", "134.170.68.0/23", "157.56.232.0/21", "191.234.140.0/22", "206.191.224.0/19", "13.107.128.0/22", "23.103.132.0/22", "23.103.136.0/21", "23.103.144.0/20", "23.103.198.0/23", "23.103.200.0/22", "40.92.0.0/14", "40.107.0.0/17", "52.96.0.0/14", "52.100.0.0/14", "52.104.0.0/14", "65.55.88.0/24", "65.55.169.0/24", "94.245.120.64/26", "104.47.0.0/17", "150.171.32.0/22", "157.55.234.0/24", "157.56.110.0/23", "157.56.112.0/24", "207.46.100.0/24", "207.46.163.0/24", "213.199.154.0/24", "216.32.180.0/23"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]

      "oa0300XXXX.m-p-nsg-anv-db-001" = ["Tcp", ["1556", "13724"], ["10.130.16.20", "10.130.16.21", "10.130.16.22", "10.130.16.23"], ["172.25.192.84", "172.25.232.57", "172.25.192.76", "172.25.192.77", "172.25.192.78", "172.25.192.79", "172.25.192.80", "172.25.192.81", "172.25.192.159", "172.25.192.160", "172.25.192.161", "172.25.192.162", "172.25.232.118", "172.25.232.119", "172.25.232.120", "172.25.232.121", "172.25.232.154", "172.25.232.155", "172.25.232.156", "172.25.232.157"]]

      "oa0300XXXX.m-p-nsg-anv-app-001" = ["Tcp", ["443"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.28.16.182", "172.28.1.141", "54.177.75.151", "54.183.38.220", "40.108.128.0/17", "13.107.18.10", "13.107.19.10", "52.238.78.88/30", "157.56.240.0/22", "191.232.96.0/23", "191.234.6.152/30", "213.199.180.128/25", "13.107.6.152", "13.107.9.152", "131.253.33.215", "204.79.197.215", "20.190.128.0/18", "40.126.0.0/18", "23.103.160.0/20", "23.103.224.0/19", "40.96.0.0/13", "40.104.0.0/15", "132.245.0.0/16", "134.170.68.0/23", "157.56.232.0/21", "191.234.140.0/22", "206.191.224.0/19", "13.107.128.0/22", "23.103.132.0/22", "23.103.136.0/21", "23.103.144.0/20", "23.103.198.0/23", "23.103.200.0/22", "40.92.0.0/14", "40.107.0.0/17", "52.96.0.0/14", "52.100.0.0/14", "52.104.0.0/14", "65.55.88.0/24", "65.55.169.0/24", "94.245.120.64/26", "104.47.0.0/17", "150.171.32.0/22", "157.55.234.0/24", "157.56.110.0/23", "157.56.112.0/24", "207.46.100.0/24", "207.46.163.0/24", "213.199.154.0/24", "216.32.180.0/23", "172.28.16.182", "172.28.1.141"]]
      "oa0301XXXX.m-p-nsg-anv-app-001" = ["Tcp", ["25"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.25.232.158", "172.25.232.159", "172.25.232.160", "172.25.232.161", "10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]
      "oa0302XXXX.m-p-nsg-anv-app-001" = ["*", ["111", "635", "4055-4056", "4044-4049", "2049", "20048", "111", "635", "2049", "4044-4049", "135-139", "445"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.28.0.152", "172.28.0.152"]]
      "oa0303XXXX.m-p-nsg-anv-app-001" = ["*", ["4044-4049", "445", "111", "635", "2049"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.28.0.76", "172.28.0.92", "172.16.101.21", "172.16.101.88", "172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.76", "172.28.0.92", "172.28.137.32", "172.28.0.74", "172.28.0.152", "172.16.101.21", "172.16.101.88", "172.25.72.26", "172.16.97.21", "172.16.97.113", "172.28.143.20", "172.28.143.84", "172.28.137.30", "172.28.137.31"]]
      "oa0304XXXX.m-p-nsg-anv-app-001" = ["Tcp", ["80"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["192.212.253.130", "192.213.136.168", "192.213.136.131", "192.212.253.131"]]
      "oa0305XXXX.m-p-nsg-anv-app-001" = ["*", ["135-139"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.74", "172.28.0.152", "172.28.143.20", "172.28.143.84"]]
      "oa0307XXXX.m-p-nsg-anv-app-001" = ["*", ["135-139", "111", "445", "635", "4044-4049", "2049"], ["10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"], ["172.28.17.37", "172.28.17.225", "172.16.103.22", "172.16.103.93"]]
    }

    nsgrule1 = {
      # "ia0100nsg-snet-lbs-01" = ["AllowP2SvpnTraffic", "Tcp", ["3389", "80"], ["10.5.3.64/26"], ["10.5.2.128/26", "10.5.2.192/26"]]
      # "id4096nsg-snet-lbs-01" = ["Deny_All", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.m-p-nsg-identity-dprout-001" = ["XXXX.m-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.m-p-nsg-identity-dprin-001" = ["XXXX.m-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

      "id4096XXXX.m-p-nsg-anv-app-001" = ["*", ["1-65535"], "*", "*"]
      "ia0297XXXX.m-p-nsg-management-agw-001-int" = ["*",["65200-65535"],"GatewayManager","*"]
      "ia0299XXXX.m-p-nsg-management-agw-001-int" = ["*",["65200-65535"],"Internet","*"]
      "id0300XXXX.m-p-nsg-management-agw-001-int" = ["*",["1-65535"],"Internet","*"]
      "ia0297XXXX.m-p-nsg-management-agw-001-ext" = ["*",["65200-65535"],"GatewayManager","*"]
      "ia0298XXXX.m-p-nsg-management-agw-001-ext" = ["*",["443"],"45.60.77.211","*"]
      "ia0299XXXX.m-p-nsg-management-agw-001-ext" = ["*",["65200-65535"],"Internet","*"]
      "id0300XXXX.m-p-nsg-management-agw-001-ext" = ["*",["1-65535"],"Internet","*"]
      # REquird - "ia0110XXXX.m-p-nsg-identity-rodc-001" = ["XXXX.m-ngr-iba-tcp-100", "Tcp", ["0-65535"], "AzureLoadBalancer", "10.130.10.192/27"]
      "ia0110XXXX.m-p-nsg-identity-rodc-001" = ["Tcp", ["0-65535"], "AzureLoadBalancer", "10.130.10.192/27"]

      #"oa0300XXXX.m-p-nsg-identity-rodc-001" = ["XXXX.m-ngr-oba-tcp-300", "Tcp", ["3389"], ["172.25.104.19", "172.25.104.20"], ["10.130.10.192/27"]]
      #"id4096XXXX.m-p-nsg-identity-rodc-001"  = ["XXXX.m-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

    }



    nsg-subnet-assoc = {
      #       nsg name = subnet name to link

      "XXXX.m-p-nsg-identity-dprout-001" = "XXXX.m-p-sub-identity-dprout-001"
      "XXXX.m-p-nsg-identity-dprin-001"  = "XXXX.m-p-sub-identity-dprin-001"
      "XXXX.m-p-nsg-identity-rodc-001"   = "XXXX.m-p-sub-identity-rodc-001"
      "XXXX.m-p-nsg-management-agw-001-int" = "XXXX.m-p-sub-management-agw-int-001"
      "XXXX.m-p-nsg-management-agw-001-ext" = "XXXX.m-p-sub-management-agw-ext-001"
      "XXXX.m-p-nsg-anv-app-001" = "XXXX.m-p-sub-anv-app-001"
      "XXXX.m-p-nsg-col-app-001" = "XXXX.m-p-sub-col-app-001"
      "XXXX.m-p-nsg-rtc-app-001" = "XXXX.m-p-sub-rtc-app-001"
      "XXXX.m-p-nsg-wsm-app-001" = "XXXX.m-p-sub-wsm-app-001"
      "XXXX.m-p-nsg-ntx-app-001" = "XXXX.m-p-sub-ntx-app-001"
      "XXXX.m-p-nsg-eng-app-001" = "XXXX.m-p-sub-eng-app-001"
      "XXXX.m-p-nsg-tdm-app-001" = "XXXX.m-p-sub-tdm-app-001"
      "XXXX.m-p-nsg-vrs-app-001" = "XXXX.m-p-sub-vrs-app-001"
      "XXXX.m-p-nsg-isr-app-001" = "XXXX.m-p-sub-isr-app-001"
      "XXXX.m-p-nsg-isr-app-002" = "XXXX.m-p-sub-isr-app-002"


      "XXXX.m-p-nsg-anv-db-001" = "XXXX.m-p-sub-anv-db-001"
      "XXXX.m-p-nsg-col-db-001" = "XXXX.m-p-sub-col-db-001"
      "XXXX.m-p-nsg-rtc-db-001" = "XXXX.m-p-sub-rtc-db-001"
      "XXXX.m-p-nsg-wsm-db-001" = "XXXX.m-p-sub-wsm-db-001"
      "XXXX.m-p-nsg-ntx-db-001" = "XXXX.m-p-sub-ntx-db-001"
      "XXXX.m-p-nsg-eng-db-001" = "XXXX.m-p-sub-eng-db-001"
      "XXXX.m-p-nsg-tdm-db-001" = "XXXX.m-p-sub-tdm-db-001"
      "XXXX.m-p-nsg-vrs-db-001" = "XXXX.m-p-sub-vrs-db-001"

      "XXXX.m-p-nsg-anv-web-001" = "XXXX.m-p-sub-anv-web-001"
      "XXXX.m-p-nsg-col-web-001" = "XXXX.m-p-sub-col-web-001"
      "XXXX.m-p-nsg-rtc-web-001" = "XXXX.m-p-sub-rtc-web-001"
      "XXXX.m-p-nsg-sca-web-001" = "XXXX.m-p-sub-sca-web-001"
      "XXXX.m-p-nsg-wsm-web-001" = "XXXX.m-p-sub-wsm-web-001"
      "XXXX.m-p-nsg-ntx-web-001" = "XXXX.m-p-sub-ntx-web-001"
      "XXXX.m-p-nsg-eng-web-001" = "XXXX.m-p-sub-eng-web-001"
      "XXXX.m-p-nsg-tdm-web-001" = "XXXX.m-p-sub-tdm-web-001"
      "XXXX.m-p-nsg-vrs-web-001" = "XXXX.m-p-sub-vrs-web-001"

    }



    route_table = {
      #  rt name = rg name

      /*"XXXX.m-p-rot-connectivity-pe-001"  = "XXXX.m-p-rgp-connectivity-001"
      "XXXX.m-p-rot-management-agw-001"   = "XXXX.m-p-rgp-management-001"
      "XXXX.m-p-rot-management-pe-001"    = "XXXX.m-p-rgp-management-001"
      "XXXX.m-p-rot-automation-pe-001"    = "XXXX.m-p-rgp-automation-001"
      "XXXX.m-p-rot-identity-dprout-001"  = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-rot-identity-dprin-001"   = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-rot-identity-rodc-001"    = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-rot-identity-pe-001"      = "XXXX.m-p-rgp-identity-001"
      "XXXX.m-p-rot-monitoring-pe-001"    = "XXXX.m-p-rgp-monitoring-001"
      "XXXX.m-p-rot-cybersecurity-pe-001" = "XXXX.m-p-rgp-cybersecurity-001"

      "XXXX.m-p-rot-anv-app-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-rot-col-app-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-rot-rtc-app-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-rot-wsm-app-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-rot-ntx-app-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-rot-eng-app-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-rot-tdm-app-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-rot-vrs-app-001" = "XXXX.m-p-rgp-vrs-001"

      "XXXX.m-p-rot-anv-db-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-rot-col-db-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-rot-rtc-db-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-rot-wsm-db-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-rot-ntx-db-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-rot-eng-db-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-rot-tdm-db-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-rot-vrs-db-001" = "XXXX.m-p-rgp-vrs-001"

      "XXXX.m-p-rot-anv-web-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-rot-col-web-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-rot-rtc-web-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-rot-wsm-web-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-rot-ntx-web-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-rot-eng-web-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-rot-tdm-web-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-rot-vrs-web-001" = "XXXX.m-p-rgp-vrs-001"

      "XXXX.m-p-rot-anv-pe-001" = "XXXX.m-p-rgp-anv-001"
      "XXXX.m-p-rot-col-pe-001" = "XXXX.m-p-rgp-col-001"
      "XXXX.m-p-rot-rtc-pe-001" = "XXXX.m-p-rgp-rtc-001"
      "XXXX.m-p-rot-wsm-pe-001" = "XXXX.m-p-rgp-wsm-001"
      "XXXX.m-p-rot-ntx-pe-001" = "XXXX.m-p-rgp-ntx-001"
      "XXXX.m-p-rot-eng-pe-001" = "XXXX.m-p-rgp-eng-001"
      "XXXX.m-p-rot-tdm-pe-001" = "XXXX.m-p-rgp-tdm-001"
      "XXXX.m-p-rot-vrs-pe-001" = "XXXX.m-p-rgp-vrs-001"*/
    }

    udr = {
      #  index = route name, rt Name, AddressSpace, next_hop_type, , next_hop_addr
      #0001 = ["default", "rt-ntw-q2-poc", "0.0.0.0/0", "VirtualAppliance", "10.5.0.132"]
      #0401 = ["default", "rt-apg-ntw-q2-poc", "0.0.0.0/0","Internet"]
      /*1  = ["XXXX.m-p-udr-fw-rotconnectivitype", "XXXX.m-p-rot-connectivity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2  = ["XXXX.m-p-udr-fw-rotmanagementagw", "XXXX.m-p-rot-management-agw-001", "0.0.0.0/0", "Internet"]
      3  = ["XXXX.m-p-udr-fw-rotmanagementpe", "XXXX.m-p-rot-management-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      4  = ["XXXX.m-p-udr-fw-rotautomationpe", "XXXX.m-p-rot-automation-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      5  = ["XXXX.m-p-udr-fw-rotidentitydprout", "XXXX.m-p-rot-identity-dprout-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      6  = ["XXXX.m-p-udr-fw-rotidentitydprin", "XXXX.m-p-rot-identity-dprin-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      7  = ["XXXX.m-p-udr-fw-rotidentitype", "XXXX.m-p-rot-identity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      8  = ["XXXX.m-p-udr-fw-rotidentityrodc", "XXXX.m-p-rot-identity-rodc-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      9  = ["XXXX.m-p-udr-fw-rotmonitoringpe", "XXXX.m-p-rot-monitoring-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      10 = ["XXXX.m-p-udr-fw-rotcybersecuritype", "XXXX.m-p-rot-cybersecurity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      11 = ["XXXX.m-p-udr-fw-rotanvapp", "XXXX.m-p-rot-anv-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      14 = ["XXXX.m-p-udr-fw-rotcolapp", "XXXX.m-p-rot-col-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      18 = ["XXXX.m-p-udr-fw-rotrtcapp", "XXXX.m-p-rot-rtc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      19 = ["XXXX.m-p-udr-fw-rotscaapp", "XXXX.m-p-rot-sca-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      20 = ["XXXX.m-p-udr-fw-rotwsmapp", "XXXX.m-p-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      22 = ["XXXX.m-p-udr-fw-rotntxapp", "XXXX.m-p-rot-ntx-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      23 = ["XXXX.m-p-udr-fw-rotengapp", "XXXX.m-p-rot-eng-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      24 = ["XXXX.m-p-udr-fw-rottdmapp", "XXXX.m-p-rot-tdm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      25 = ["XXXX.m-p-udr-fw-rotvrsapp", "XXXX.m-p-rot-vrs-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      200 = ["XXXX.m-p-udr-fw-rotanvdb", "XXXX.m-p-rot-anv-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      203 = ["XXXX.m-p-udr-fw-rotcoldb", "XXXX.m-p-rot-col-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      207 = ["XXXX.m-p-udr-fw-rotrtcdb", "XXXX.m-p-rot-rtc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      208 = ["XXXX.m-p-udr-fw-rotscadb", "XXXX.m-p-rot-sca-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      209 = ["XXXX.m-p-udr-fw-rotwsmdb", "XXXX.m-p-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      211 = ["XXXX.m-p-udr-fw-rotntxdb", "XXXX.m-p-rot-ntx-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      212 = ["XXXX.m-p-udr-fw-rotengdb", "XXXX.m-p-rot-eng-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      213 = ["XXXX.m-p-udr-fw-rottdmdb", "XXXX.m-p-rot-tdm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      214 = ["XXXX.m-p-udr-fw-rotvrsdb", "XXXX.m-p-rot-vrs-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      400 = ["XXXX.m-p-udr-fw-rotanvweb", "XXXX.m-p-rot-anv-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      403 = ["XXXX.m-p-udr-fw-rotcolweb", "XXXX.m-p-rot-col-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      407 = ["XXXX.m-p-udr-fw-rotrtcweb", "XXXX.m-p-rot-rtc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      409 = ["XXXX.m-p-udr-fw-rotwsmweb", "XXXX.m-p-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      411 = ["XXXX.m-p-udr-fw-rotntxweb", "XXXX.m-p-rot-ntx-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      412 = ["XXXX.m-p-udr-fw-rotengweb", "XXXX.m-p-rot-eng-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      413 = ["XXXX.m-p-udr-fw-rottdmweb", "XXXX.m-p-rot-tdm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      414 = ["XXXX.m-p-udr-fw-rotvrsweb", "XXXX.m-p-rot-vrs-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      2400 = ["XXXX.m-p-udr-fw-rotanvpe", "XXXX.m-p-rot-anv-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2403 = ["XXXX.m-p-udr-fw-rotcolpe", "XXXX.m-p-rot-col-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2407 = ["XXXX.m-p-udr-fw-rotrtcpe", "XXXX.m-p-rot-rtc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2409 = ["XXXX.m-p-udr-fw-rotwsmpe", "XXXX.m-p-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2411 = ["XXXX.m-p-udr-fw-rotntxpe", "XXXX.m-p-rot-ntx-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2412 = ["XXXX.m-p-udr-fw-rotengpe", "XXXX.m-p-rot-eng-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2413 = ["XXXX.m-p-udr-fw-rottdmpe", "XXXX.m-p-rot-tdm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2414 = ["XXXX.m-p-udr-fw-rotvrspe", "XXXX.m-p-rot-vrs-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
    }


    rt_assoc = {
      # "subnet1" = "rt-apg-ntw-q2-poc" 

      /*XXXX.m-p-rot-connectivity-pe-001"  = "XXXX.m-p-sub-connectivity-pe-001"
      "XXXX.m-p-rot-management-agw-001"   = "XXXX.m-p-sub-management-agw-001"
      "XXXX.m-p-rot-management-pe-001"    = "XXXX.m-p-sub-management-pe-001"
      "XXXX.m-p-rot-automation-pe-001"    = "XXXX.m-p-sub-automation-pe-001"
      "XXXX.m-p-rot-identity-dprout-001"  = "XXXX.m-p-sub-identity-dprout-001"
      "XXXX.m-p-rot-identity-dprin-001"   = "XXXX.m-p-sub-identity-dprin-001"
      "XXXX.m-p-rot-identity-pe-001"      = "XXXX.m-p-sub-identity-pe-001"
      "XXXX.m-p-rot-identity-rodc-001"    = "XXXX.m-p-sub-identity-rodc-001"
      "XXXX.m-p-rot-monitoring-pe-001"    = "XXXX.m-p-sub-monitoring-pe-001"
      "XXXX.m-p-rot-cybersecurity-pe-001" = "XXXX.m-p-sub-cybersecurity-pe-001"

      "XXXX.m-p-rot-anv-app-001" = "XXXX.m-p-sub-anv-app-001"
      "XXXX.m-p-rot-col-app-001" = "XXXX.m-p-sub-col-app-001"
      "XXXX.m-p-rot-rtc-app-001" = "XXXX.m-p-sub-rtc-app-001"
      "XXXX.m-p-rot-wsm-app-001" = "XXXX.m-p-sub-wsm-app-001"
      "XXXX.m-p-rot-ntx-app-001" = "XXXX.m-p-sub-ntx-app-001"
      "XXXX.m-p-rot-eng-app-001" = "XXXX.m-p-sub-eng-app-001"
      "XXXX.m-p-rot-tdm-app-001" = "XXXX.m-p-sub-tdm-app-001"
      "XXXX.m-p-rot-vrs-app-001" = "XXXX.m-p-sub-vrs-app-001"

      "XXXX.m-p-rot-anv-db-001" = "XXXX.m-p-sub-anv-db-001"
      "XXXX.m-p-rot-col-db-001" = "XXXX.m-p-sub-col-db-001"
      "XXXX.m-p-rot-rtc-db-001" = "XXXX.m-p-sub-rtc-db-001"
      "XXXX.m-p-rot-wsm-db-001" = "XXXX.m-p-sub-wsm-db-001"
      "XXXX.m-p-rot-ntx-db-001" = "XXXX.m-p-sub-ntx-db-001"
      "XXXX.m-p-rot-eng-db-001" = "XXXX.m-p-sub-eng-db-001"
      "XXXX.m-p-rot-tdm-db-001" = "XXXX.m-p-sub-tdm-db-001"
      "XXXX.m-p-rot-vrs-db-001" = "XXXX.m-p-sub-vrs-db-001"

      "XXXX.m-p-rot-anv-web-001" = "XXXX.m-p-sub-anv-web-001"
      "XXXX.m-p-rot-col-web-001" = "XXXX.m-p-sub-col-web-001"
      "XXXX.m-p-rot-rtc-web-001" = "XXXX.m-p-sub-rtc-web-001"
      "XXXX.m-p-rot-wsm-web-001" = "XXXX.m-p-sub-wsm-web-001"
      "XXXX.m-p-rot-ntx-web-001" = "XXXX.m-p-sub-ntx-web-001"
      "XXXX.m-p-rot-eng-web-001" = "XXXX.m-p-sub-eng-web-001"
      "XXXX.m-p-rot-tdm-web-001" = "XXXX.m-p-sub-tdm-web-001"
      "XXXX.m-p-rot-vrs-web-001" = "XXXX.m-p-sub-vrs-web-001"

      "XXXX.m-p-rot-anv-pe-001" = "XXXX.m-p-sub-anv-pe-001"
      "XXXX.m-p-rot-col-pe-001" = "XXXX.m-p-sub-col-pe-001"
      "XXXX.m-p-rot-rtc-pe-001" = "XXXX.m-p-sub-rtc-pe-001"
      "XXXX.m-p-rot-wsm-pe-001" = "XXXX.m-p-sub-wsm-pe-001"
      "XXXX.m-p-rot-ntx-pe-001" = "XXXX.m-p-sub-ntx-pe-001"
      "XXXX.m-p-rot-eng-pe-001" = "XXXX.m-p-sub-eng-pe-001"
      "XXXX.m-p-rot-tdm-pe-001" = "XXXX.m-p-sub-tdm-pe-001"
      "XXXX.m-p-rot-vrs-pe-001" = "XXXX.m-p-sub-vrs-pe-001"*/
    }

  }


}