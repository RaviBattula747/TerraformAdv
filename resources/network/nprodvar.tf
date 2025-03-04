#=========================================================================================================================
#=========================================================================================================================
#=========================================================================================================================
#                                                    NON PROD Variables
#=========================================================================================================================
#=========================================================================================================================
#=========================================================================================================================
locals {
  nprod = {


    # common important variables
    location = "West US 3"
    env      = "nprod"
    vhub_id  = "/subscriptions/5d8XXXXXXXXXXXXXXXXXXXXXXXXXXX4fe6ffb6e5/resourceGroups/XXXX.-p-rgp-connectivity-001/providers/Microsoft.Network/virtualHubs/XXXX.-p-vhb-connectivity-001"

    # resource vise variables start from here


    rg = {
      #"rg1" = "sub1"
      "XXXX.-d-rgp-anv-001" = "XXXX.-d-sbr-anv"
      "XXXX.-d-rgp-col-001" = "XXXX.-d-sbr-col"
      "XXXX.-d-rgp-rtc-001" = "XXXX.-d-sbr-rtc"
      "XXXX.-d-rgp-wsm-001" = "XXXX.-d-sbr-wsm"
      "XXXX.-d-rgp-ntx-001" = "XXXX.-d-sbr-ntx"
      "XXXX.-d-rgp-eng-001" = "XXXX.-d-sbr-eng"
      "XXXX.-d-rgp-tdm-001" = "XXXX.-d-sbr-tdm"
      "XXXX.-d-rgp-vrs-001" = "XXXX.-d-sbr-vrs"
      "XXXX.-d-rgp-isr-001" = "XXXX.-d-sbr-isr"

      "XXXX.-f-rgp-anv-001" = "XXXX.-d-sbr-anv"
      "XXXX.-f-rgp-col-001" = "XXXX.-d-sbr-col"
      "XXXX.-f-rgp-rtc-001" = "XXXX.-d-sbr-rtc"
      "XXXX.-f-rgp-wsm-001" = "XXXX.-d-sbr-wsm"
      "XXXX.-f-rgp-ntx-001" = "XXXX.-d-sbr-ntx"
      "XXXX.-f-rgp-eng-001" = "XXXX.-d-sbr-eng"
      "XXXX.-f-rgp-tdm-001" = "XXXX.-d-sbr-tdm"
      "XXXX.-f-rgp-vrs-001" = "XXXX.-d-sbr-vrs"

      "XXXX.-q-rgp-anv-001" = "XXXX.-d-sbr-anv"
      "XXXX.-q-rgp-col-001" = "XXXX.-d-sbr-col"
      "XXXX.-q-rgp-rtc-001" = "XXXX.-d-sbr-rtc"
      "XXXX.-q-rgp-wsm-001" = "XXXX.-d-sbr-wsm"
      "XXXX.-q-rgp-ntx-001" = "XXXX.-d-sbr-ntx"
      "XXXX.-q-rgp-eng-001" = "XXXX.-d-sbr-eng"
      "XXXX.-q-rgp-tdm-001" = "XXXX.-d-sbr-tdm"
      "XXXX.-q-rgp-vrs-001" = "XXXX.-d-sbr-vrs"


    }

    vwan = {
      name                = "XXXX.-p-vwn-connectivity"
      resource_group_name = "XXXX.-p-rgp-connectivity-001"
    }

    vhub = {
      name                = "XXXX.-p-vhb-connectivity-001"
      resource_group_name = "XXXX.-p-rgp-connectivity-001"
      address_prefix      = "10.130.0.0/23"
      vwan_id             = "/subscriptions/5d847XXXXXXXXXXXXXXXXXXXXXXXXXXfb6e5/resourceGroups/XXXX.-p-rgp-connectivity-001/providers/Microsoft.Network/virtualWans/XXXX.-p-vwn-connectivity"
    }

    hubpeers = [
      "XXXX.-p-vnt-connectivity-001", "XXXX.-p-vnt-identity-001", "XXXX.-p-vnt-automation-001", "XXXX.-p-vnt-cybersecurity-001", "XXXX.-p-vnt-management-001", "XXXX.-p-vnt-monitoring-001", "XXXX.-d-vnt-anv-001", "XXXX.-d-vnt-apg-001", "XXXX.-d-vnt-ase-001", "XXXX.-d-vnt-col-001", "XXXX.-d-vnt-emp-001", "XXXX.-d-vnt-nar-001",
      "XXXX.-d-vnt-roc-001", "XXXX.-d-vnt-rtc-001", "XXXX.-d-vnt-sca-001", "XXXX.-d-vnt-wsm-001", "XXXX.-d-vnt-ntx-001",
      "XXXX.-d-vnt-eng-001", "XXXX.-d-vnt-tdm-001", "XXXX.-d-vnt-vrs-001", "XXXX.-d-vnt-isr-001"

    ]

    fw = {
      "fw1" = "XXXX.-p-cfw-elz-001-westus3pa"
    }
    panoramastack = {
      "XXXX.-p-cfw-elz-001-westus3" = {
        panorama_base64_config       = "eyJkZ25hbWUiOiAiXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXR1czMiLCAicGFub3Jhb=="
        resource_group_name          = "XXXX.-p-rgp-connectivity-001"
        network_virtual_appliance_id = "fw1"
        public_ip_address_ids        = ["/subscriptions/5d8XXXXXXXXXXXXXXXXXXXffb6e5/resourceGroups/XXXX.-p-rgp-connectivity-001/providers/Microsoft.Network/publicIPAddresses/XXXX.-p-pip-connectivity-001-cngfw"]
        trusted_address_ranges       = ["155.13.0.0/16", "163.236.0.0/16", "192.212.0.0/15", "192.214.0.0/18", "192.214.64.0/19", "192.214.96.0/24"]
      }
    }

    rtintent = {}

    pips = {
      #pip name     = Rg name

    }


    erg = {
      name                = "XXXX.-p-vng-exr-connectivity-01"
      resource_group_name = "XXXX.-p-rgp-connectivity-001"
      scale_units         = 5
    }

    bst = {
      name                = "XXXX.-p-bst-management-001"
      resource_group_name = "XXXX.-p-rgp-management-001"
      scale_units         = 5
      ip_name             = "XXXX.-p-pip-management-001-bastion"
      subnet_name         = "AzureBastionSubnet"
    }
    apg = {
    }
    apg1 = {}

    dpr = {
      name                = "XXXX.-p-dpr-identity-001"
      resource_group_name = "XXXX.-p-rgp-identity-001"
      virtual_network_id  = "XXXX.-p-vnt-identity-001"

      inputendpoint = {
        #name                     = [private_dns_resolver_id,subnet_id]
        #"in"                    = ["apr-sce","XXXX.-p-sub-identity-dprin-001"]
      }
      outputendpoint = {
        #name                           = [private_dns_resolver_id,subnet_id]
        "on-prem-Infoblox-endpoint" = ["XXXX.-p-dpr-identity-001", "XXXX.-p-sub-identity-dprout-001"]
      }
      forwardingruleset = {
        #name                                       =   [rg, out_ep_id]
        "XXXX.-p-frs-identity-001" = ["XXXX.-p-rgp-identity-001", "on-prem-Infoblox-endpoint"]
      }
      forwardingrule = {
        #vnet_name                      =   [dns_forwarding_ruleset_id, domain_name]
        "XXXX.-p-frl-identity-001" = ["XXXX.-p-frs-identity-001", "."]
      }
      dpr_virtual_network_link = {
        #vnet_name                      =  dns_forwarding_ruleset_id
        "XXXX.-d-vnt-anv-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-apg-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-ase-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-col-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-emp-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-nar-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-roc-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-rtc-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-sca-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-wsm-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-ntx-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-eng-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-tdm-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-vrs-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
        "XXXX.-d-vnt-isr-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-p-frs-identity-001"
      }
    }

    virtual_network = {

      "XXXX.-d-vnt-anv-001" = {
        address_space       = ["10.130.16.64/26", "10.130.16.128/25"]
        resource_group_name = "XXXX.-d-rgp-anv-001"
      }

      "XXXX.-d-vnt-col-001" = {
        address_space       = ["10.130.19.64/26", "10.130.19.128/25"]
        resource_group_name = "XXXX.-d-rgp-col-001"
      }

      "XXXX.-d-vnt-rtc-001" = {
        address_space       = ["10.130.23.64/26", "10.130.23.128/25"]
        resource_group_name = "XXXX.-d-rgp-rtc-001"
      }

      "XXXX.-d-vnt-wsm-001" = {
        address_space       = ["10.130.25.64/26", "10.130.25.128/25"]
        resource_group_name = "XXXX.-d-rgp-wsm-001"
      }

      "XXXX.-d-vnt-ntx-001" = {
        address_space       = ["10.130.27.64/26", "10.130.27.128/25"]
        resource_group_name = "XXXX.-d-rgp-ntx-001"
      }

      "XXXX.-d-vnt-eng-001" = {
        address_space       = ["10.130.28.64/26", "10.130.28.128/25"]
        resource_group_name = "XXXX.-d-rgp-eng-001"
      }

      "XXXX.-d-vnt-tdm-001" = {
        address_space       = ["10.130.29.64/26", "10.130.29.128/25", "10.130.31.192/26"]
        resource_group_name = "XXXX.-d-rgp-tdm-001"
      }

      "XXXX.-d-vnt-vrs-001" = {
        address_space       = ["10.130.30.64/26", "10.130.30.128/25"]
        resource_group_name = "XXXX.-d-rgp-vrs-001"
      }

      "XXXX.-d-vnt-isr-001" = {
        address_space       = ["10.130.37.64/26", "10.130.37.128/25"]
        resource_group_name = "XXXX.-d-rgp-isr-001"
      }


    }


    subnet = {
      #  addr Prefix = [vnet name,subnet name] 

      "XXXX.-q-sub-tdm-msql-001" = ["XXXX.-d-vnt-tdm-001", "10.130.31.192/26"]

      "XXXX.-d-sub-anv-app-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.64/28"]
      "XXXX.-d-sub-col-app-001" = ["XXXX.-d-vnt-col-001", "10.130.19.64/28"]
      "XXXX.-d-sub-rtc-app-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.64/28"]
      "XXXX.-d-sub-wsm-app-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.64/28"]
      "XXXX.-d-sub-ntx-app-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.64/28"]
      "XXXX.-d-sub-eng-app-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.64/28"]
      "XXXX.-d-sub-tdm-app-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.64/28"]
      "XXXX.-d-sub-vrs-app-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.64/28"]
      "XXXX.-d-sub-isr-app-001" = ["XXXX.-d-vnt-isr-001", "10.130.37.64/27"]
      "XXXX.-d-sub-isr-app-002" = ["XXXX.-d-vnt-isr-001", "10.130.37.96/28"]
      "XXXX.-d-sub-isr-app-003" = ["XXXX.-d-vnt-isr-001", "10.130.37.128/28"]
      "XXXX.-d-sub-isr-app-004" = ["XXXX.-d-vnt-isr-001", "10.130.37.144/28"]
      "XXXX.-d-sub-isr-app-005" = ["XXXX.-d-vnt-isr-001", "10.130.37.160/28"]
      "XXXX.-d-sub-isr-app-006" = ["XXXX.-d-vnt-isr-001", "10.130.37.176/28"]

      "XXXX.-d-sub-anv-db-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.80/28"]
      "XXXX.-d-sub-col-db-001" = ["XXXX.-d-vnt-col-001", "10.130.19.80/28"]
      "XXXX.-d-sub-rtc-db-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.80/28"]
      "XXXX.-d-sub-wsm-db-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.80/28"]
      "XXXX.-d-sub-ntx-db-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.80/28"]
      "XXXX.-d-sub-eng-db-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.80/28"]
      "XXXX.-d-sub-tdm-db-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.80/28"]
      "XXXX.-d-sub-vrs-db-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.80/28"]

      "XXXX.-d-sub-anv-web-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.96/28"]
      "XXXX.-d-sub-col-web-001" = ["XXXX.-d-vnt-col-001", "10.130.19.96/28"]
      "XXXX.-d-sub-rtc-web-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.96/28"]
      "XXXX.-d-sub-sca-web-001" = ["XXXX.-d-vnt-sca-001", "10.130.24.96/28"]
      "XXXX.-d-sub-wsm-web-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.96/28"]
      "XXXX.-d-sub-ntx-web-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.96/28"]
      "XXXX.-d-sub-eng-web-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.96/28"]
      "XXXX.-d-sub-tdm-web-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.96/28"]
      "XXXX.-d-sub-vrs-web-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.96/28"]

      "XXXX.-d-sub-anv-pe-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.112/28"]
      "XXXX.-d-sub-col-pe-001" = ["XXXX.-d-vnt-col-001", "10.130.19.112/28"]
      "XXXX.-d-sub-rtc-pe-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.112/28"]
      "XXXX.-d-sub-wsm-pe-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.112/28"]
      "XXXX.-d-sub-ntx-pe-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.112/28"]
      "XXXX.-d-sub-eng-pe-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.112/28"]
      "XXXX.-d-sub-tdm-pe-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.112/28"]
      "XXXX.-d-sub-vrs-pe-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.112/28"]
      "XXXX.-d-sub-isr-pe-001" = ["XXXX.-d-vnt-isr-001", "10.130.37.112/28"]
      "XXXX.-d-sub-isr-pe-002" = ["XXXX.-d-vnt-isr-001", "10.130.37.192/28"]

      "XXXX.-f-sub-anv-app-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.128/28"]
      "XXXX.-f-sub-col-app-001" = ["XXXX.-d-vnt-col-001", "10.130.19.128/28"]
      "XXXX.-f-sub-rtc-app-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.128/28"]
      "XXXX.-f-sub-wsm-app-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.128/28"]
      "XXXX.-f-sub-ntx-app-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.128/28"]
      "XXXX.-f-sub-eng-app-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.128/28"]
      "XXXX.-f-sub-tdm-app-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.128/28"]
      "XXXX.-f-sub-vrs-app-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.128/28"]

      "XXXX.-f-sub-anv-db-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.144/28"]
      "XXXX.-f-sub-col-db-001" = ["XXXX.-d-vnt-col-001", "10.130.19.144/28"]
      "XXXX.-f-sub-rtc-db-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.144/28"]
      "XXXX.-f-sub-wsm-db-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.144/28"]
      "XXXX.-f-sub-ntx-db-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.144/28"]
      "XXXX.-f-sub-eng-db-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.144/28"]
      "XXXX.-f-sub-tdm-db-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.144/28"]
      "XXXX.-f-sub-vrs-db-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.144/28"]

      "XXXX.-f-sub-anv-web-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.160/28"]
      "XXXX.-f-sub-col-web-001" = ["XXXX.-d-vnt-col-001", "10.130.19.160/28"]
      "XXXX.-f-sub-rtc-web-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.160/28"]
      "XXXX.-f-sub-wsm-web-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.160/28"]
      "XXXX.-f-sub-ntx-web-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.160/28"]
      "XXXX.-f-sub-eng-web-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.160/28"]
      "XXXX.-f-sub-tdm-web-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.160/28"]
      "XXXX.-f-sub-vrs-web-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.160/28"]

      "XXXX.-f-sub-anv-pe-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.176/28"]
      "XXXX.-f-sub-col-pe-001" = ["XXXX.-d-vnt-col-001", "10.130.19.176/28"]
      "XXXX.-f-sub-rtc-pe-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.176/28"]
      "XXXX.-f-sub-sca-pe-001" = ["XXXX.-d-vnt-sca-001", "10.130.24.176/28"]
      "XXXX.-f-sub-wsm-pe-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.176/28"]
      "XXXX.-f-sub-ntx-pe-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.176/28"]
      "XXXX.-f-sub-eng-pe-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.176/28"]
      "XXXX.-f-sub-tdm-pe-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.176/28"]
      "XXXX.-f-sub-vrs-pe-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.176/28"]

      "XXXX.-q-sub-anv-app-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.192/28"]
      "XXXX.-q-sub-col-app-001" = ["XXXX.-d-vnt-col-001", "10.130.19.192/28"]
      "XXXX.-q-sub-rtc-app-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.192/28"]
      "XXXX.-q-sub-wsm-app-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.192/28"]
      "XXXX.-q-sub-ntx-app-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.192/28"]
      "XXXX.-q-sub-eng-app-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.192/28"]
      "XXXX.-q-sub-tdm-app-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.192/28"]
      "XXXX.-q-sub-vrs-app-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.192/28"]

      "XXXX.-q-sub-anv-db-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.208/28"]
      "XXXX.-q-sub-col-db-001" = ["XXXX.-d-vnt-col-001", "10.130.19.208/28"]
      "XXXX.-q-sub-rtc-db-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.208/28"]
      "XXXX.-q-sub-wsm-db-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.208/28"]
      "XXXX.-q-sub-ntx-db-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.208/28"]
      "XXXX.-q-sub-eng-db-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.208/28"]
      "XXXX.-q-sub-tdm-db-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.208/28"]
      "XXXX.-q-sub-vrs-db-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.208/28"]

      "XXXX.-q-sub-anv-web-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.224/28"]
      "XXXX.-q-sub-col-web-001" = ["XXXX.-d-vnt-col-001", "10.130.19.224/28"]
      "XXXX.-q-sub-rtc-web-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.224/28"]
      "XXXX.-q-sub-wsm-web-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.224/28"]
      "XXXX.-q-sub-ntx-web-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.224/28"]
      "XXXX.-q-sub-eng-web-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.224/28"]
      "XXXX.-q-sub-tdm-web-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.224/28"]
      "XXXX.-q-sub-vrs-web-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.224/28"]

      "XXXX.-q-sub-anv-pe-001" = ["XXXX.-d-vnt-anv-001", "10.130.16.240/28"]
      "XXXX.-q-sub-col-pe-001" = ["XXXX.-d-vnt-col-001", "10.130.19.240/28"]
      "XXXX.-q-sub-rtc-pe-001" = ["XXXX.-d-vnt-rtc-001", "10.130.23.240/28"]
      "XXXX.-q-sub-wsm-pe-001" = ["XXXX.-d-vnt-wsm-001", "10.130.25.240/28"]
      "XXXX.-q-sub-ntx-pe-001" = ["XXXX.-d-vnt-ntx-001", "10.130.27.240/28"]
      "XXXX.-q-sub-eng-pe-001" = ["XXXX.-d-vnt-eng-001", "10.130.28.240/28"]
      "XXXX.-q-sub-tdm-pe-001" = ["XXXX.-d-vnt-tdm-001", "10.130.29.240/28"]
      "XXXX.-q-sub-vrs-pe-001" = ["XXXX.-d-vnt-vrs-001", "10.130.30.240/28"]

    }

    nsg = {
      #  nsg_name = rg name

      "XXXX.-d-nsg-anv-app-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-nsg-col-app-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-nsg-rtc-app-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-nsg-wsm-app-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-nsg-ntx-app-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-nsg-eng-app-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-nsg-tdm-app-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-nsg-vrs-app-001" = "XXXX.-d-rgp-vrs-001"
      "XXXX.-d-nsg-isr-app-001" = "XXXX.-d-rgp-isr-001"
      "XXXX.-d-nsg-isr-app-002" = "XXXX.-d-rgp-isr-001"
      "XXXX.-d-nsg-isr-app-003" = "XXXX.-d-rgp-isr-001"
      "XXXX.-d-nsg-isr-app-004" = "XXXX.-d-rgp-isr-001"
      "XXXX.-d-nsg-isr-app-005" = "XXXX.-d-rgp-isr-001"
      "XXXX.-d-nsg-isr-app-006" = "XXXX.-d-rgp-isr-001"


      "XXXX.-d-nsg-anv-db-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-nsg-col-db-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-nsg-rtc-db-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-nsg-wsm-db-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-nsg-ntx-db-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-nsg-eng-db-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-nsg-tdm-db-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-nsg-vrs-db-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-d-nsg-anv-web-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-nsg-col-web-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-nsg-rtc-web-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-nsg-wsm-web-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-nsg-ntx-web-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-nsg-eng-web-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-nsg-tdm-web-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-nsg-vrs-web-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-f-nsg-anv-app-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-nsg-col-app-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-nsg-rtc-app-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-nsg-wsm-app-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-nsg-ntx-app-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-nsg-eng-app-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-nsg-tdm-app-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-nsg-vrs-app-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-f-nsg-anv-db-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-nsg-col-db-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-nsg-rtc-db-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-nsg-wsm-db-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-nsg-ntx-db-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-nsg-eng-db-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-nsg-tdm-db-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-nsg-vrs-db-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-f-nsg-anv-web-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-nsg-col-web-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-nsg-rtc-web-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-nsg-wsm-web-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-nsg-ntx-web-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-nsg-eng-web-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-nsg-tdm-web-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-nsg-vrs-web-001" = "XXXX.-f-rgp-vrs-001"


      "XXXX.-q-nsg-anv-app-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-nsg-col-app-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-nsg-rtc-app-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-nsg-wsm-app-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-nsg-ntx-app-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-nsg-eng-app-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-nsg-tdm-app-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-nsg-vrs-app-001" = "XXXX.-q-rgp-vrs-001"

      "XXXX.-q-nsg-anv-db-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-nsg-col-db-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-nsg-rtc-db-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-nsg-wsm-db-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-nsg-ntx-db-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-nsg-eng-db-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-nsg-tdm-db-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-nsg-vrs-db-001" = "XXXX.-q-rgp-vrs-001"

      "XXXX.-q-nsg-anv-web-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-nsg-col-web-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-nsg-rtc-web-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-nsg-wsm-web-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-nsg-ntx-web-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-nsg-eng-web-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-nsg-tdm-web-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-nsg-vrs-web-001" = "XXXX.-q-rgp-vrs-001"

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
      #"id4096XXXX.-p-nsg-identity-dprout-001" = ["XXXX.-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

      "oa0300XXXX.-q-nsg-anv-app-001" = ["Tcp", ["443"], ["10.130.16.196", "10.130.16.197"], ["172.28.16.182", "172.28.1.141", "54.177.75.151", "54.183.38.220", "40.108.128.0/17", "13.107.18.10", "13.107.19.10", "52.238.78.88/30", "157.56.240.0/22", "191.232.96.0/23", "191.234.6.152/30", "213.199.180.128/25", "13.107.6.152", "13.107.9.152", "131.253.33.215", "204.79.197.215", "20.190.128.0/18", "40.126.0.0/18", "23.103.160.0/20", "23.103.224.0/19", "40.96.0.0/13", "40.104.0.0/15", "132.245.0.0/16", "134.170.68.0/23", "157.56.232.0/21", "191.234.140.0/22", "206.191.224.0/19", "13.107.128.0/22", "23.103.132.0/22", "23.103.136.0/21", "23.103.144.0/20", "23.103.198.0/23", "23.103.200.0/22", "40.92.0.0/14", "40.107.0.0/17", "52.96.0.0/14", "52.100.0.0/14", "52.104.0.0/14", "65.55.88.0/24", "65.55.169.0/24", "94.245.120.64/26", "104.47.0.0/17", "150.171.32.0/22", "157.55.234.0/24", "157.56.110.0/23", "157.56.112.0/24", "207.46.100.0/24", "207.46.163.0/24", "213.199.154.0/24", "216.32.180.0/23", "172.28.16.182", "172.28.1.141"]]
      "oa0301XXXX.-q-nsg-anv-app-001" = ["Tcp", ["25"], ["10.130.16.196", "10.130.16.197"], ["172.25.232.158", "172.25.232.159", "172.25.232.160", "172.25.232.161", "10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]
      "oa0302XXXX.-q-nsg-anv-app-001" = ["*", ["111", "635", "4055-4056", "4044-4049", "2049", "20048", "111", "635", "2049", "4044-4049", "135-139", "445"], ["10.130.16.196", "10.130.16.197"], ["172.28.0.152", "172.28.0.152"]]
      "oa0303XXXX.-q-nsg-anv-app-001" = ["*", ["4044-4049", "445", "111", "635", "2049"], ["10.130.16.196", "10.130.16.197"], ["172.28.0.76", "172.28.0.92", "172.16.101.21", "172.16.101.88", "172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.76", "172.28.0.92", "172.28.137.32", "172.28.0.74", "172.28.0.152", "172.16.101.21", "172.16.101.88", "172.25.72.26", "172.16.97.21", "172.16.97.113", "172.28.143.20", "172.28.143.84", "172.28.137.30", "172.28.137.31"]]
      "oa0304XXXX.-q-nsg-anv-app-001" = ["Tcp", ["80"], ["10.130.16.196", "10.130.16.197"], ["192.212.253.130", "192.213.136.168", "192.213.136.131", "192.212.253.131"]]
      "oa0305XXXX.-q-nsg-anv-app-001" = ["*", ["135-139"], ["10.130.16.196", "10.130.16.197"], ["172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.74", "172.28.0.152", "172.28.143.20", "172.28.143.84"]]
      "oa0306XXXX.-q-nsg-anv-app-001" = ["Tcp", ["805", "80", "443"], ["10.130.16.196", "10.130.16.197"], ["172.25.248.127", "172.25.248.125"]]
      "oa0307XXXX.-q-nsg-anv-app-001" = ["*", ["135-139", "111", "445", "635", "4044-4049", "2049"], ["10.130.16.196", "10.130.16.197"], ["172.16.101.23", "172.16.101.87", "172.28.0.74", "172.28.0.152"]]

      "ia0300XXXX.-q-nsg-anv-db-001" = ["Tcp", ["1433", "1984"], ["172.16.204.68"], ["10.130.16.212"]]
      "ia0301XXXX.-q-nsg-anv-db-001" = ["Tcp", ["1433", "1988", "445", "1434", "1984", "1989", "1994", "1999"], ["172.28.42.95"], ["10.130.16.212"]]
      /*
      "oa0300XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-tcp-300", "Tcp", ["443"], ["10.130.16.196", "10.130.16.197"], ["172.28.16.182", "172.28.1.141", "54.177.75.151", "54.183.38.220", "40.108.128.0/17", "13.107.18.10", "13.107.19.10", "52.238.78.88/30", "157.56.240.0/22", "191.232.96.0/23", "191.234.6.152/30", "213.199.180.128/25", "13.107.6.152", "13.107.9.152", "131.253.33.215", "204.79.197.215", "20.190.128.0/18", "40.126.0.0/18", "23.103.160.0/20", "23.103.224.0/19", "40.96.0.0/13", "40.104.0.0/15", "132.245.0.0/16", "134.170.68.0/23", "157.56.232.0/21", "191.234.140.0/22", "206.191.224.0/19", "13.107.128.0/22", "23.103.132.0/22", "23.103.136.0/21", "23.103.144.0/20", "23.103.198.0/23", "23.103.200.0/22", "40.92.0.0/14", "40.107.0.0/17", "52.96.0.0/14", "52.100.0.0/14", "52.104.0.0/14", "65.55.88.0/24", "65.55.169.0/24", "94.245.120.64/26", "104.47.0.0/17", "150.171.32.0/22", "157.55.234.0/24", "157.56.110.0/23", "157.56.112.0/24", "207.46.100.0/24", "207.46.163.0/24", "213.199.154.0/24", "216.32.180.0/23", "172.28.16.182", "172.28.1.141"]]
      "oa0301XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-tcp-301", "Tcp", ["25"], ["10.130.16.196", "10.130.16.197"], ["172.25.232.158", "172.25.232.159", "172.25.232.160", "172.25.232.161", "10.130.16.4", "10.130.16.5", "10.130.16.6", "10.130.16.7"]]
      "oa0302XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-any-302", "*", ["111", "635", "4055-4056", "4044-4049", "2049", "20048", "111", "635", "2049", "4044-4049", "135-139", "445"], ["10.130.16.196", "10.130.16.197"], ["172.28.0.152", "172.28.0.152"]]
      "oa0303XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-any-303", "*", ["4044-4049", "445", "111", "635", "2049"], ["10.130.16.196", "10.130.16.197"], ["172.28.0.76", "172.28.0.92", "172.16.101.21", "172.16.101.88", "172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.76", "172.28.0.92", "172.28.137.32", "172.28.0.74", "172.28.0.152", "172.16.101.21", "172.16.101.88", "172.25.72.26", "172.16.97.21", "172.16.97.113", "172.28.143.20", "172.28.143.84", "172.28.137.30", "172.28.137.31"]]
      "oa0304XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-tcp-304", "Tcp", ["80"], ["10.130.16.196", "10.130.16.197"], ["192.212.253.130", "192.213.136.168", "192.213.136.131", "192.212.253.131"]]
      "oa0305XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-any-305", "*", ["135-139"], ["10.130.16.196", "10.130.16.197"], ["172.28.128.31", "172.28.128.32", "192.212.52.137", "172.16.101.23", "172.16.101.87", "172.16.99.22", "172.16.99.132", "172.28.0.74", "172.28.0.152", "172.28.143.20", "172.28.143.84"]]
      "oa0306XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-tcp-306", "Tcp", ["805", "80", "443"], ["10.130.16.196", "10.130.16.197"], ["172.25.248.127", "172.25.248.125"]]
      "oa0307XXXX.-q-nsg-anv-app-001" = ["XXXX.-ngr-oba-any-307", "*", ["135-139", "111", "445", "635", "4044-4049", "2049"], ["10.130.16.196", "10.130.16.197"], ["172.16.101.23", "172.16.101.87", "172.28.0.74", "172.28.0.152"]]

      "ia0300XXXX.-q-nsg-anv-db-001" = ["XXXX.-ngr-iba-tcp-300", "Tcp", ["1433", "1984"], ["172.16.204.68"], ["10.130.16.212"]]
      "ia0301XXXX.-q-nsg-anv-db-001" = ["XXXX.-ngr-iba-tcp-301", "Tcp", ["1433", "1988", "445", "1434", "1984", "1989", "1994", "1999"], ["172.28.42.95"], ["10.130.16.212"]]
*/

      #-p-nsg-identity-rodc-001" = ["XXXX.-ngr-oba-tcp-300", "Tcp", ["3389"], ["172.25.104.19", "172.25.104.20"], ["10.130.10.192/27"]]
      #"id4096XXXX.-p-nsg-identity-rodc-001"  = ["XXXX.-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

    }

    nsgrule1 = {

    }

    nsg-subnet-assoc = {
      #       nsg name = subnet name to link

      "XXXX.-d-nsg-anv-app-001" = "XXXX.-d-sub-anv-app-001"
      "XXXX.-d-nsg-col-app-001" = "XXXX.-d-sub-col-app-001"
      "XXXX.-d-nsg-rtc-app-001" = "XXXX.-d-sub-rtc-app-001"
      "XXXX.-d-nsg-wsm-app-001" = "XXXX.-d-sub-wsm-app-001"
      "XXXX.-d-nsg-ntx-app-001" = "XXXX.-d-sub-ntx-app-001"
      "XXXX.-d-nsg-eng-app-001" = "XXXX.-d-sub-eng-app-001"
      "XXXX.-d-nsg-tdm-app-001" = "XXXX.-d-sub-tdm-app-001"
      "XXXX.-d-nsg-vrs-app-001" = "XXXX.-d-sub-vrs-app-001"
      "XXXX.-d-nsg-isr-app-001" = "XXXX.-d-sub-isr-app-001"
      "XXXX.-d-nsg-isr-app-002" = "XXXX.-d-sub-isr-app-002"
      "XXXX.-d-nsg-isr-app-003" = "XXXX.-d-sub-isr-app-003"
      "XXXX.-d-nsg-isr-app-004" = "XXXX.-d-sub-isr-app-004"
      "XXXX.-d-nsg-isr-app-005" = "XXXX.-d-sub-isr-app-005"
      "XXXX.-d-nsg-isr-app-006" = "XXXX.-d-sub-isr-app-006"

      "XXXX.-d-nsg-anv-db-001" = "XXXX.-d-sub-anv-db-001"
      "XXXX.-d-nsg-col-db-001" = "XXXX.-d-sub-col-db-001"
      "XXXX.-d-nsg-rtc-db-001" = "XXXX.-d-sub-rtc-db-001"
      "XXXX.-d-nsg-wsm-db-001" = "XXXX.-d-sub-wsm-db-001"
      "XXXX.-d-nsg-ntx-db-001" = "XXXX.-d-sub-ntx-db-001"
      "XXXX.-d-nsg-eng-db-001" = "XXXX.-d-sub-eng-db-001"
      "XXXX.-d-nsg-tdm-db-001" = "XXXX.-d-sub-tdm-db-001"
      "XXXX.-d-nsg-vrs-db-001" = "XXXX.-d-sub-vrs-db-001"

      "XXXX.-d-nsg-anv-web-001" = "XXXX.-d-sub-anv-web-001"
      "XXXX.-d-nsg-col-web-001" = "XXXX.-d-sub-col-web-001"
      "XXXX.-d-nsg-rtc-web-001" = "XXXX.-d-sub-rtc-web-001"
      "XXXX.-d-nsg-wsm-web-001" = "XXXX.-d-sub-wsm-web-001"
      "XXXX.-d-nsg-ntx-web-001" = "XXXX.-d-sub-ntx-web-001"
      "XXXX.-d-nsg-eng-web-001" = "XXXX.-d-sub-eng-web-001"
      "XXXX.-d-nsg-tdm-web-001" = "XXXX.-d-sub-tdm-web-001"
      "XXXX.-d-nsg-vrs-web-001" = "XXXX.-d-sub-vrs-web-001"

      "XXXX.-f-nsg-anv-app-001" = "XXXX.-f-sub-anv-app-001"
      "XXXX.-f-nsg-col-app-001" = "XXXX.-f-sub-col-app-001"
      "XXXX.-f-nsg-rtc-app-001" = "XXXX.-f-sub-rtc-app-001"
      "XXXX.-f-nsg-wsm-app-001" = "XXXX.-f-sub-wsm-app-001"
      "XXXX.-f-nsg-ntx-app-001" = "XXXX.-f-sub-ntx-app-001"
      "XXXX.-f-nsg-eng-app-001" = "XXXX.-f-sub-eng-app-001"
      "XXXX.-f-nsg-tdm-app-001" = "XXXX.-f-sub-tdm-app-001"
      "XXXX.-f-nsg-vrs-app-001" = "XXXX.-f-sub-vrs-app-001"

      "XXXX.-f-nsg-anv-db-001" = "XXXX.-f-sub-anv-db-001"
      "XXXX.-f-nsg-col-db-001" = "XXXX.-f-sub-col-db-001"
      "XXXX.-f-nsg-rtc-db-001" = "XXXX.-f-sub-rtc-db-001"
      "XXXX.-f-nsg-wsm-db-001" = "XXXX.-f-sub-wsm-db-001"
      "XXXX.-f-nsg-ntx-db-001" = "XXXX.-f-sub-ntx-db-001"
      "XXXX.-f-nsg-eng-db-001" = "XXXX.-f-sub-eng-db-001"
      "XXXX.-f-nsg-tdm-db-001" = "XXXX.-f-sub-tdm-db-001"
      "XXXX.-f-nsg-vrs-db-001" = "XXXX.-f-sub-vrs-db-001"

      "XXXX.-f-nsg-anv-web-001" = "XXXX.-f-sub-anv-web-001"
      "XXXX.-f-nsg-col-web-001" = "XXXX.-f-sub-col-web-001"
      "XXXX.-f-nsg-rtc-web-001" = "XXXX.-f-sub-rtc-web-001"
      "XXXX.-f-nsg-wsm-web-001" = "XXXX.-f-sub-wsm-web-001"
      "XXXX.-f-nsg-ntx-web-001" = "XXXX.-f-sub-ntx-web-001"
      "XXXX.-f-nsg-eng-web-001" = "XXXX.-f-sub-eng-web-001"
      "XXXX.-f-nsg-tdm-web-001" = "XXXX.-f-sub-tdm-web-001"
      "XXXX.-f-nsg-vrs-web-001" = "XXXX.-f-sub-vrs-web-001"

      "XXXX.-q-nsg-anv-app-001" = "XXXX.-q-sub-anv-app-001"
      "XXXX.-q-nsg-col-app-001" = "XXXX.-q-sub-col-app-001"
      "XXXX.-q-nsg-rtc-app-001" = "XXXX.-q-sub-rtc-app-001"
      "XXXX.-q-nsg-wsm-app-001" = "XXXX.-q-sub-wsm-app-001"
      "XXXX.-q-nsg-ntx-app-001" = "XXXX.-q-sub-ntx-app-001"
      "XXXX.-q-nsg-eng-app-001" = "XXXX.-q-sub-eng-app-001"
      "XXXX.-q-nsg-tdm-app-001" = "XXXX.-q-sub-tdm-app-001"
      "XXXX.-q-nsg-vrs-app-001" = "XXXX.-q-sub-vrs-app-001"

      "XXXX.-q-nsg-anv-db-001" = "XXXX.-q-sub-anv-db-001"
      "XXXX.-q-nsg-col-db-001" = "XXXX.-q-sub-col-db-001"
      "XXXX.-q-nsg-rtc-db-001" = "XXXX.-q-sub-rtc-db-001"
      "XXXX.-q-nsg-wsm-db-001" = "XXXX.-q-sub-wsm-db-001"
      "XXXX.-q-nsg-ntx-db-001" = "XXXX.-q-sub-ntx-db-001"
      "XXXX.-q-nsg-eng-db-001" = "XXXX.-q-sub-eng-db-001"
      "XXXX.-q-nsg-tdm-db-001" = "XXXX.-q-sub-tdm-db-001"
      "XXXX.-q-nsg-vrs-db-001" = "XXXX.-q-sub-vrs-db-001"

      "XXXX.-q-nsg-anv-web-001" = "XXXX.-q-sub-anv-web-001"
      "XXXX.-q-nsg-col-web-001" = "XXXX.-q-sub-col-web-001"
      "XXXX.-q-nsg-rtc-web-001" = "XXXX.-q-sub-rtc-web-001"
      "XXXX.-q-nsg-wsm-web-001" = "XXXX.-q-sub-wsm-web-001"
      "XXXX.-q-nsg-ntx-web-001" = "XXXX.-q-sub-ntx-web-001"
      "XXXX.-q-nsg-eng-web-001" = "XXXX.-q-sub-eng-web-001"
      "XXXX.-q-nsg-tdm-web-001" = "XXXX.-q-sub-tdm-web-001"
      "XXXX.-q-nsg-vrs-web-001" = "XXXX.-q-sub-vrs-web-001"

    }

    route_table = {
      #  rt name = rg name

      /*"XXXX.-d-rot-anv-app-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-rot-col-app-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-rot-rtc-app-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-rot-wsm-app-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-rot-ntx-app-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-rot-eng-app-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-rot-tdm-app-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-rot-vrs-app-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-d-rot-anv-db-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-rot-col-db-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-rot-rtc-db-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-rot-wsm-db-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-rot-ntx-db-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-rot-eng-db-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-rot-tdm-db-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-rot-vrs-db-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-d-rot-anv-web-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-rot-col-web-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-rot-rtc-web-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-rot-wsm-web-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-rot-ntx-web-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-rot-eng-web-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-rot-tdm-web-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-rot-vrs-web-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-d-rot-anv-pe-001" = "XXXX.-d-rgp-anv-001"
      "XXXX.-d-rot-col-pe-001" = "XXXX.-d-rgp-col-001"
      "XXXX.-d-rot-rtc-pe-001" = "XXXX.-d-rgp-rtc-001"
      "XXXX.-d-rot-wsm-pe-001" = "XXXX.-d-rgp-wsm-001"
      "XXXX.-d-rot-ntx-pe-001" = "XXXX.-d-rgp-ntx-001"
      "XXXX.-d-rot-eng-pe-001" = "XXXX.-d-rgp-eng-001"
      "XXXX.-d-rot-tdm-pe-001" = "XXXX.-d-rgp-tdm-001"
      "XXXX.-d-rot-vrs-pe-001" = "XXXX.-d-rgp-vrs-001"

      "XXXX.-f-rot-anv-app-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-rot-col-app-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-rot-rtc-app-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-rot-wsm-app-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-rot-ntx-app-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-rot-eng-app-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-rot-tdm-app-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-rot-vrs-app-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-f-rot-anv-db-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-rot-col-db-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-rot-rtc-db-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-rot-wsm-db-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-rot-ntx-db-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-rot-eng-db-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-rot-tdm-db-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-rot-vrs-db-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-f-rot-anv-web-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-rot-col-web-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-rot-rtc-web-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-rot-wsm-web-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-rot-ntx-web-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-rot-eng-web-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-rot-tdm-web-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-rot-vrs-web-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-f-rot-anv-pe-001" = "XXXX.-f-rgp-anv-001"
      "XXXX.-f-rot-col-pe-001" = "XXXX.-f-rgp-col-001"
      "XXXX.-f-rot-rtc-pe-001" = "XXXX.-f-rgp-rtc-001"
      "XXXX.-f-rot-wsm-pe-001" = "XXXX.-f-rgp-wsm-001"
      "XXXX.-f-rot-ntx-pe-001" = "XXXX.-f-rgp-ntx-001"
      "XXXX.-f-rot-eng-pe-001" = "XXXX.-f-rgp-eng-001"
      "XXXX.-f-rot-tdm-pe-001" = "XXXX.-f-rgp-tdm-001"
      "XXXX.-f-rot-vrs-pe-001" = "XXXX.-f-rgp-vrs-001"

      "XXXX.-q-rot-anv-app-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-rot-col-app-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-rot-rtc-app-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-rot-wsm-app-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-rot-ntx-app-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-rot-eng-app-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-rot-tdm-app-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-rot-vrs-app-001" = "XXXX.-q-rgp-vrs-001"

      "XXXX.-q-rot-anv-db-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-rot-col-db-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-rot-rtc-db-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-rot-wsm-db-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-rot-ntx-db-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-rot-eng-db-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-rot-tdm-db-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-rot-vrs-db-001" = "XXXX.-q-rgp-vrs-001"

      "XXXX.-q-rot-anv-web-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-rot-col-web-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-rot-rtc-web-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-rot-wsm-web-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-rot-ntx-web-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-rot-eng-web-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-rot-tdm-web-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-rot-vrs-web-001" = "XXXX.-q-rgp-vrs-001"

      "XXXX.-q-rot-anv-pe-001" = "XXXX.-q-rgp-anv-001"
      "XXXX.-q-rot-col-pe-001" = "XXXX.-q-rgp-col-001"
      "XXXX.-q-rot-rtc-pe-001" = "XXXX.-q-rgp-rtc-001"
      "XXXX.-q-rot-wsm-pe-001" = "XXXX.-q-rgp-wsm-001"
      "XXXX.-q-rot-ntx-pe-001" = "XXXX.-q-rgp-ntx-001"
      "XXXX.-q-rot-eng-pe-001" = "XXXX.-q-rgp-eng-001"
      "XXXX.-q-rot-tdm-pe-001" = "XXXX.-q-rgp-tdm-001"
      "XXXX.-q-rot-vrs-pe-001" = "XXXX.-q-rgp-vrs-001"*/
    }

    udr = {
      #  index = route name, rt Name, AddressSpace, next_hop_type, , next_hop_addr
      #0001 = ["default", "rt-ntw-q2-poc", "0.0.0.0/0", "VirtualAppliance", "10.5.0.132"]
      #0401 = ["default", "rt-apg-ntw-q2-poc", "0.0.0.0/0","Internet"]

      /*600 = ["XXXX.-d-udr-fw-rotanvapp", "XXXX.-d-rot-anv-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      603 = ["XXXX.-d-udr-fw-rotcolapp", "XXXX.-d-rot-col-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      607 = ["XXXX.-d-udr-fw-rotrtcapp", "XXXX.-d-rot-rtc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      609 = ["XXXX.-d-udr-fw-rotwsmapp", "XXXX.-d-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      611 = ["XXXX.-d-udr-fw-rotntxapp", "XXXX.-d-rot-ntx-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      612 = ["XXXX.-d-udr-fw-rotengapp", "XXXX.-d-rot-eng-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      613 = ["XXXX.-d-udr-fw-rottdmapp", "XXXX.-d-rot-tdm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      614 = ["XXXX.-d-udr-fw-rotvrsapp", "XXXX.-d-rot-vrs-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      800 = ["XXXX.-d-udr-fw-rotanvdb", "XXXX.-d-rot-anv-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      803 = ["XXXX.-d-udr-fw-rotcoldb", "XXXX.-d-rot-col-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      807 = ["XXXX.-d-udr-fw-rotrtcdb", "XXXX.-d-rot-rtc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      809 = ["XXXX.-d-udr-fw-rotwsmdb", "XXXX.-d-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      811 = ["XXXX.-d-udr-fw-rotntxdb", "XXXX.-d-rot-ntx-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      812 = ["XXXX.-d-udr-fw-rotengdb", "XXXX.-d-rot-eng-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      813 = ["XXXX.-d-udr-fw-rottdmdb", "XXXX.-d-rot-tdm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      814 = ["XXXX.-d-udr-fw-rotvrsdb", "XXXX.-d-rot-vrs-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      1000 = ["XXXX.-d-udr-fw-rotanvweb", "XXXX.-d-rot-anv-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1003 = ["XXXX.-d-udr-fw-rotcolweb", "XXXX.-d-rot-col-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1007 = ["XXXX.-d-udr-fw-rotrtcweb", "XXXX.-d-rot-rtc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1009 = ["XXXX.-d-udr-fw-rotwsmweb", "XXXX.-d-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1011 = ["XXXX.-d-udr-fw-rotntxweb", "XXXX.-d-rot-ntx-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1012 = ["XXXX.-d-udr-fw-rotengweb", "XXXX.-d-rot-eng-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1013 = ["XXXX.-d-udr-fw-rottdmweb", "XXXX.-d-rot-tdm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1014 = ["XXXX.-d-udr-fw-rotvrsweb", "XXXX.-d-rot-vrs-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      2600 = ["XXXX.-d-udr-fw-rotanvpe", "XXXX.-d-rot-anv-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2603 = ["XXXX.-d-udr-fw-rotcolpe", "XXXX.-d-rot-col-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2607 = ["XXXX.-d-udr-fw-rotrtcpe", "XXXX.-d-rot-rtc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2609 = ["XXXX.-d-udr-fw-rotwsmpe", "XXXX.-d-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2611 = ["XXXX.-d-udr-fw-rotntxpe", "XXXX.-d-rot-ntx-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2612 = ["XXXX.-d-udr-fw-rotengpe", "XXXX.-d-rot-eng-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2613 = ["XXXX.-d-udr-fw-rottdmpe", "XXXX.-d-rot-tdm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2614 = ["XXXX.-d-udr-fw-rotvrspe", "XXXX.-d-rot-vrs-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      1200 = ["XXXX.-f-udr-fw-rotanvapp", "XXXX.-f-rot-anv-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1203 = ["XXXX.-f-udr-fw-rotcolapp", "XXXX.-f-rot-col-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1207 = ["XXXX.-f-udr-fw-rotrtcapp", "XXXX.-f-rot-rtc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1209 = ["XXXX.-f-udr-fw-rotwsmapp", "XXXX.-f-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1211 = ["XXXX.-f-udr-fw-rotntxapp", "XXXX.-f-rot-ntx-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1212 = ["XXXX.-f-udr-fw-rotengapp", "XXXX.-f-rot-eng-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1213 = ["XXXX.-f-udr-fw-rottdmapp", "XXXX.-f-rot-tdm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1214 = ["XXXX.-f-udr-fw-rotvrsapp", "XXXX.-f-rot-vrs-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      1400 = ["XXXX.-f-udr-fw-rotanvdb", "XXXX.-f-rot-anv-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1403 = ["XXXX.-f-udr-fw-rotcoldb", "XXXX.-f-rot-col-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1407 = ["XXXX.-f-udr-fw-rotrtcdb", "XXXX.-f-rot-rtc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1409 = ["XXXX.-f-udr-fw-rotwsmdb", "XXXX.-f-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1411 = ["XXXX.-f-udr-fw-rotntxdb", "XXXX.-f-rot-ntx-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1412 = ["XXXX.-f-udr-fw-rotengdb", "XXXX.-f-rot-eng-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1413 = ["XXXX.-f-udr-fw-rottdmdb", "XXXX.-f-rot-tdm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1414 = ["XXXX.-f-udr-fw-rotvrsdb", "XXXX.-f-rot-vrs-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      1600 = ["XXXX.-f-udr-fw-rotanvweb", "XXXX.-f-rot-anv-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1603 = ["XXXX.-f-udr-fw-rotcolweb", "XXXX.-f-rot-col-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1607 = ["XXXX.-f-udr-fw-rotrtcweb", "XXXX.-f-rot-rtc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1609 = ["XXXX.-f-udr-fw-rotwsmweb", "XXXX.-f-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1611 = ["XXXX.-f-udr-fw-rotntxweb", "XXXX.-f-rot-ntx-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1612 = ["XXXX.-f-udr-fw-rotengweb", "XXXX.-f-rot-eng-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1613 = ["XXXX.-f-udr-fw-rottdmweb", "XXXX.-f-rot-tdm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1614 = ["XXXX.-f-udr-fw-rotvrsweb", "XXXX.-f-rot-vrs-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      2800 = ["XXXX.-f-udr-fw-rotanvpe", "XXXX.-f-rot-anv-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2803 = ["XXXX.-f-udr-fw-rotcolpe", "XXXX.-f-rot-col-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2807 = ["XXXX.-f-udr-fw-rotrtcpe", "XXXX.-f-rot-rtc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2809 = ["XXXX.-f-udr-fw-rotwsmpe", "XXXX.-f-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2811 = ["XXXX.-f-udr-fw-rotntxpe", "XXXX.-f-rot-ntx-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2812 = ["XXXX.-f-udr-fw-rotengpe", "XXXX.-f-rot-eng-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2813 = ["XXXX.-f-udr-fw-rottdmpe", "XXXX.-f-rot-tdm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2814 = ["XXXX.-f-udr-fw-rotvrspe", "XXXX.-f-rot-vrs-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      1800 = ["XXXX.-q-udr-fw-rotanvapp", "XXXX.-q-rot-anv-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1803 = ["XXXX.-q-udr-fw-rotcolapp", "XXXX.-q-rot-col-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1807 = ["XXXX.-q-udr-fw-rotrtcapp", "XXXX.-q-rot-rtc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1809 = ["XXXX.-q-udr-fw-rotwsmapp", "XXXX.-q-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1811 = ["XXXX.-q-udr-fw-rotntxapp", "XXXX.-q-rot-ntx-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1812 = ["XXXX.-q-udr-fw-rotengapp", "XXXX.-q-rot-eng-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1813 = ["XXXX.-q-udr-fw-rottdmapp", "XXXX.-q-rot-tdm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      1814 = ["XXXX.-q-udr-fw-rotvrsapp", "XXXX.-q-rot-vrs-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      2000 = ["XXXX.-q-udr-fw-rotanvdb", "XXXX.-q-rot-anv-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2003 = ["XXXX.-q-udr-fw-rotcoldb", "XXXX.-q-rot-col-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2007 = ["XXXX.-q-udr-fw-rotrtcdb", "XXXX.-q-rot-rtc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2009 = ["XXXX.-q-udr-fw-rotwsmdb", "XXXX.-q-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2011 = ["XXXX.-q-udr-fw-rotntxdb", "XXXX.-q-rot-ntx-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2012 = ["XXXX.-q-udr-fw-rotengdb", "XXXX.-q-rot-eng-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2013 = ["XXXX.-q-udr-fw-rottdmdb", "XXXX.-q-rot-tdm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2014 = ["XXXX.-q-udr-fw-rotvrsdb", "XXXX.-q-rot-vrs-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      2200 = ["XXXX.-q-udr-fw-rotanvweb", "XXXX.-q-rot-anv-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2203 = ["XXXX.-q-udr-fw-rotcolweb", "XXXX.-q-rot-col-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2207 = ["XXXX.-q-udr-fw-rotrtcweb", "XXXX.-q-rot-rtc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2209 = ["XXXX.-q-udr-fw-rotwsmweb", "XXXX.-q-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2211 = ["XXXX.-q-udr-fw-rotntxweb", "XXXX.-q-rot-ntx-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2212 = ["XXXX.-q-udr-fw-rotengweb", "XXXX.-q-rot-eng-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2213 = ["XXXX.-q-udr-fw-rottdmweb", "XXXX.-q-rot-tdm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      2214 = ["XXXX.-q-udr-fw-rotvrsweb", "XXXX.-q-rot-vrs-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]

      #3000 = ["XXXX.-q-udr-fw-rotanvpe", "XXXX.-q-rot-anv-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3003 = ["XXXX.-q-udr-fw-rotcolpe", "XXXX.-q-rot-col-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3007 = ["XXXX.-q-udr-fw-rotrtcpe", "XXXX.-q-rot-rtc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3009 = ["XXXX.-q-udr-fw-rotwsmpe", "XXXX.-q-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3011 = ["XXXX.-q-udr-fw-rotntxpe", "XXXX.-q-rot-ntx-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3012 = ["XXXX.-q-udr-fw-rotengpe", "XXXX.-q-rot-eng-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3013 = ["XXXX.-q-udr-fw-rottdmpe", "XXXX.-q-rot-tdm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      3014 = ["XXXX.-q-udr-fw-rotvrspe", "XXXX.-q-rot-vrs-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/

    }

    rt_assoc = {
      # "subnet1" = "rt-apg-ntw-q2-poc" 
      /*"XXXX.-d-rot-anv-app-001" = "XXXX.-d-sub-anv-app-001"
      "XXXX.-d-rot-col-app-001" = "XXXX.-d-sub-col-app-001"
      "XXXX.-d-rot-rtc-app-001" = "XXXX.-d-sub-rtc-app-001"
      "XXXX.-d-rot-wsm-app-001" = "XXXX.-d-sub-wsm-app-001"
      "XXXX.-d-rot-ntx-app-001" = "XXXX.-d-sub-ntx-app-001"
      "XXXX.-d-rot-eng-app-001" = "XXXX.-d-sub-eng-app-001"
      "XXXX.-d-rot-tdm-app-001" = "XXXX.-d-sub-tdm-app-001"
      "XXXX.-d-rot-vrs-app-001" = "XXXX.-d-sub-vrs-app-001"

      "XXXX.-d-rot-anv-db-001" = "XXXX.-d-sub-anv-db-001"
      "XXXX.-d-rot-col-db-001" = "XXXX.-d-sub-col-db-001"
      "XXXX.-d-rot-rtc-db-001" = "XXXX.-d-sub-rtc-db-001"
      "XXXX.-d-rot-wsm-db-001" = "XXXX.-d-sub-wsm-db-001"
      "XXXX.-d-rot-ntx-db-001" = "XXXX.-d-sub-ntx-db-001"
      "XXXX.-d-rot-eng-db-001" = "XXXX.-d-sub-eng-db-001"
      "XXXX.-d-rot-tdm-db-001" = "XXXX.-d-sub-tdm-db-001"
      "XXXX.-d-rot-vrs-db-001" = "XXXX.-d-sub-vrs-db-001"

      "XXXX.-d-rot-anv-web-001" = "XXXX.-d-sub-anv-web-001"
      "XXXX.-d-rot-col-web-001" = "XXXX.-d-sub-col-web-001"
      "XXXX.-d-rot-rtc-web-001" = "XXXX.-d-sub-rtc-web-001"
      "XXXX.-d-rot-wsm-web-001" = "XXXX.-d-sub-wsm-web-001"
      "XXXX.-d-rot-ntx-web-001" = "XXXX.-d-sub-ntx-web-001"
      "XXXX.-d-rot-eng-web-001" = "XXXX.-d-sub-eng-web-001"
      "XXXX.-d-rot-tdm-web-001" = "XXXX.-d-sub-tdm-web-001"
      "XXXX.-d-rot-vrs-web-001" = "XXXX.-d-sub-vrs-web-001"

      "XXXX.-d-rot-anv-pe-001" = "XXXX.-d-sub-anv-pe-001"
      "XXXX.-d-rot-col-pe-001" = "XXXX.-d-sub-col-pe-001"
      "XXXX.-d-rot-rtc-pe-001" = "XXXX.-d-sub-rtc-pe-001"
      "XXXX.-d-rot-wsm-pe-001" = "XXXX.-d-sub-wsm-pe-001"
      "XXXX.-d-rot-ntx-pe-001" = "XXXX.-d-sub-ntx-pe-001"
      "XXXX.-d-rot-eng-pe-001" = "XXXX.-d-sub-eng-pe-001"
      "XXXX.-d-rot-tdm-pe-001" = "XXXX.-d-sub-tdm-pe-001"
      "XXXX.-d-rot-vrs-pe-001" = "XXXX.-d-sub-vrs-pe-001"

      "XXXX.-f-rot-anv-app-001" = "XXXX.-f-sub-anv-app-001"
      "XXXX.-f-rot-col-app-001" = "XXXX.-f-sub-col-app-001"
      "XXXX.-f-rot-rtc-app-001" = "XXXX.-f-sub-rtc-app-001"
      "XXXX.-f-rot-wsm-app-001" = "XXXX.-f-sub-wsm-app-001"
      "XXXX.-f-rot-ntx-app-001" = "XXXX.-f-sub-ntx-app-001"
      "XXXX.-f-rot-eng-app-001" = "XXXX.-f-sub-eng-app-001"
      "XXXX.-f-rot-tdm-app-001" = "XXXX.-f-sub-tdm-app-001"
      "XXXX.-f-rot-vrs-app-001" = "XXXX.-f-sub-vrs-app-001"

      "XXXX.-f-rot-anv-db-001" = "XXXX.-f-sub-anv-db-001"
      "XXXX.-f-rot-col-db-001" = "XXXX.-f-sub-col-db-001"
      "XXXX.-f-rot-rtc-db-001" = "XXXX.-f-sub-rtc-db-001"
      "XXXX.-f-rot-wsm-db-001" = "XXXX.-f-sub-wsm-db-001"
      "XXXX.-f-rot-ntx-db-001" = "XXXX.-f-sub-ntx-db-001"
      "XXXX.-f-rot-eng-db-001" = "XXXX.-f-sub-eng-db-001"
      "XXXX.-f-rot-tdm-db-001" = "XXXX.-f-sub-tdm-db-001"
      "XXXX.-f-rot-vrs-db-001" = "XXXX.-f-sub-vrs-db-001"

      "XXXX.-f-rot-anv-web-001" = "XXXX.-f-sub-anv-web-001"
      "XXXX.-f-rot-col-web-001" = "XXXX.-f-sub-col-web-001"
      "XXXX.-f-rot-rtc-web-001" = "XXXX.-f-sub-rtc-web-001"
      "XXXX.-f-rot-wsm-web-001" = "XXXX.-f-sub-wsm-web-001"
      "XXXX.-f-rot-ntx-web-001" = "XXXX.-f-sub-ntx-web-001"
      "XXXX.-f-rot-eng-web-001" = "XXXX.-f-sub-eng-web-001"
      "XXXX.-f-rot-tdm-web-001" = "XXXX.-f-sub-tdm-web-001"
      "XXXX.-f-rot-vrs-web-001" = "XXXX.-f-sub-vrs-web-001"

      "XXXX.-f-rot-anv-pe-001" = "XXXX.-f-sub-anv-pe-001"
      "XXXX.-f-rot-col-pe-001" = "XXXX.-f-sub-col-pe-001"
      "XXXX.-f-rot-rtc-pe-001" = "XXXX.-f-sub-rtc-pe-001"
      "XXXX.-f-rot-wsm-pe-001" = "XXXX.-f-sub-wsm-pe-001"
      "XXXX.-f-rot-ntx-pe-001" = "XXXX.-f-sub-ntx-pe-001"
      "XXXX.-f-rot-eng-pe-001" = "XXXX.-f-sub-eng-pe-001"
      "XXXX.-f-rot-tdm-pe-001" = "XXXX.-f-sub-tdm-pe-001"
      "XXXX.-f-rot-vrs-pe-001" = "XXXX.-f-sub-vrs-pe-001"

      "XXXX.-q-rot-anv-app-001" = "XXXX.-q-sub-anv-app-001"
      "XXXX.-q-rot-col-app-001" = "XXXX.-q-sub-col-app-001"
      "XXXX.-q-rot-rtc-app-001" = "XXXX.-q-sub-rtc-app-001"
      "XXXX.-q-rot-wsm-app-001" = "XXXX.-q-sub-wsm-app-001"
      "XXXX.-q-rot-ntx-app-001" = "XXXX.-q-sub-ntx-app-001"
      "XXXX.-q-rot-eng-app-001" = "XXXX.-q-sub-eng-app-001"
      "XXXX.-q-rot-tdm-app-001" = "XXXX.-q-sub-tdm-app-001"
      "XXXX.-q-rot-vrs-app-001" = "XXXX.-q-sub-vrs-app-001"

      "XXXX.-q-rot-anv-db-001" = "XXXX.-q-sub-anv-db-001"
      "XXXX.-q-rot-col-db-001" = "XXXX.-q-sub-col-db-001"
      "XXXX.-q-rot-rtc-db-001" = "XXXX.-q-sub-rtc-db-001"
      "XXXX.-q-rot-wsm-db-001" = "XXXX.-q-sub-wsm-db-001"
      "XXXX.-q-rot-ntx-db-001" = "XXXX.-q-sub-ntx-db-001"
      "XXXX.-q-rot-eng-db-001" = "XXXX.-q-sub-eng-db-001"
      "XXXX.-q-rot-tdm-db-001" = "XXXX.-q-sub-tdm-db-001"
      "XXXX.-q-rot-vrs-db-001" = "XXXX.-q-sub-vrs-db-001"

      "XXXX.-q-rot-anv-web-001" = "XXXX.-q-sub-anv-web-001"
      "XXXX.-q-rot-col-web-001" = "XXXX.-q-sub-col-web-001"
      "XXXX.-q-rot-rtc-web-001" = "XXXX.-q-sub-rtc-web-001"
      "XXXX.-q-rot-wsm-web-001" = "XXXX.-q-sub-wsm-web-001"
      "XXXX.-q-rot-ntx-web-001" = "XXXX.-q-sub-ntx-web-001"
      "XXXX.-q-rot-eng-web-001" = "XXXX.-q-sub-eng-web-001"
      "XXXX.-q-rot-tdm-web-001" = "XXXX.-q-sub-tdm-web-001"
      "XXXX.-q-rot-vrs-web-001" = "XXXX.-q-sub-vrs-web-001"

      "XXXX.-q-rot-anv-pe-001" = "XXXX.-q-sub-anv-pe-001"
      "XXXX.-q-rot-col-pe-001" = "XXXX.-q-sub-col-pe-001"
      "XXXX.-q-rot-rtc-pe-001" = "XXXX.-q-sub-rtc-pe-001"
      "XXXX.-q-rot-wsm-pe-001" = "XXXX.-q-sub-wsm-pe-001"
      "XXXX.-q-rot-ntx-pe-001" = "XXXX.-q-sub-ntx-pe-001"
      "XXXX.-q-rot-eng-pe-001" = "XXXX.-q-sub-eng-pe-001"
      "XXXX.-q-rot-tdm-pe-001" = "XXXX.-q-sub-tdm-pe-001"
      "XXXX.-q-rot-vrs-pe-001" = "XXXX.-q-sub-vrs-pe-001"*/
    }

  }
}