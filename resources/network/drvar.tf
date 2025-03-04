
locals {
  dr = {


    # common important variables
    location = "East US"
    env      = "prod"
    vhub_id  = "/subscriptions/5d847XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXX.-b-rgp-connectivity-001-eastus/providers/Microsoft.Network/virtualHubs/XXXX.-b-vhb-connectivity-001-eastus"

    # resource vise variables start from here


    rg = {
      #"rg1" = "sub1"
      "XXXX.-b-rgp-connectivity-001-eastus"  = "XXXX.-b-sbr-connectivity"
      "XXXX.-b-rgp-identity-001-eastus"      = "XXXX.-b-sbr-identity"
      "XXXX.-b-rgp-management-001-eastus"    = "XXXX.-b-sbr-management"
      "XXXX.-b-rgp-automation-001-eastus"    = "XXXX.-b-sbr-automation"
      "XXXX.-b-rgp-cybersecurity-001-eastus" = "XXXX.-b-sbr-cybersecurity"
      "XXXX.-b-rgp-monitoring-001-eastus"    = "XXXX.-b-sbr-monitoring"
    }

    vwan = {
      name                = "XXXX.-b-vwn-connectivity"
      resource_group_name = "XXXX.-b-rgp-connectivity-001-eastus"
    }

    vhub = {
      name                = "XXXX.-b-vhb-connectivity-001-eastus"
      resource_group_name = "XXXX.-b-rgp-connectivity-001-eastus"
      address_prefix      = "10.133.0.0/23"
      vwan_id             = "/subscriptions/5d84XXXXXXXXb6e5/resourceGroups/XXXX.-p-rgp-connectivity-001/providers/Microsoft.Network/virtualWans/XXXX.-p-vwn-connectivity"
    }

    hubpeers = [
      "XXXX.-b-vnt-connectivity-001", "XXXX.-b-vnt-identity-001", "XXXX.-b-vnt-automation-001", "XXXX.-b-vnt-cybersecurity-001", "XXXX.-b-vnt-monitoring-001", "XXXX.-b-vnt-management-001"

    ]

    fw = {
      "fw1" = "XXXX.-b-cfw-elz-001-eastuspa"
      #"fw1" = "XXXX.-b-cfw-connectivity-001-eastus"
    }
    panoramastack = {
      "XXXX.-b-cfw-elz-001-eastus" = {
        panorama_base64_config       = "eyJkZ25hbWUiXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdHMtZWFzdHVzIiwgInBhbm9yYW1hLXNlcnZlciI6ICIxMC4xMjkuMTQuMTQwIiwgImNnbmFtZSI6ICJPcHMtQ29sbGVjdG9ycyIsICJwYW5vcmFtYS1zZXJ2ZXItMiI6ICIxMC4xMjkuNzkuMTQwIiwgInZtLXNlcmllcy1hdXRvLXJlZ2lzdHJhdGlvbi1waW4taWQiOiAiNDUwNWQ3NTQtY2MxMC00M2E3LTgzYmMtYmM4ZWZhMTI0ODQ2IiwgInZtLXNlcmllcy1hdXRvLXJlZ2lzdHJhdGlvbi1waW4tdmFsdWUiOiAiNWU5YWRjNGY0MGE3NGExZWE2ODE5YjY2YjVhYTk0MDciLCAidm0tYXV0aC1rZXkiOiAiNzIyMjQ4Mzg4NDc5Nzg1IiwgImV4cGlyeSI6ICIyMDI1LzEwLzAyIn0="
        resource_group_name          = "XXXX.-b-rgp-connectivity-001-eastus"
        network_virtual_appliance_id = "fw1"
        public_ip_address_ids        = ["/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/XXXX.-b-rgp-connectivity-001-eastus/providers/Microsoft.Network/publicIPAddresses/XXXX.-b-pip-connectivity-001-cngfw"]
        trusted_address_ranges       = ["155.13.0.0/16", "163.236.0.0/16", "192.212.0.0/15", "192.214.0.0/18", "192.214.64.0/19", "192.214.96.0/24"]
      }

    }

    rtintent = {}

    pips = {
      #pip name     = Rg name
      "XXXX.-b-pip-connectivity-001-cngfw" = "XXXX.-b-rgp-connectivity-001-eastus"
      "XXXX.-b-pip-management-001-bastion" = "XXXX.-b-rgp-management-001-eastus"
      "XXXX.-b-pip-management-001-appgtw"  = "XXXX.-b-rgp-management-001-eastus"
    }


    erg = {
      name                = "XXXX.-b-vng-exr-connectivity-01"
      resource_group_name = "XXXX.-b-rgp-connectivity-001-eastus"
      scale_units         = 5
    }

    bst = {
      name                = "XXXX.-b-bst-management-001"
      resource_group_name = "XXXX.-b-rgp-management-001-eastus"
      scale_units         = 2
      ip_name             = "XXXX.-b-pip-management-001-bastion"
      subnet_name         = "AzureBastionSubnet"
    }

    apg  = {}
    apg1 = {}

    dpr = {
      name                = "XXXX.-b-dpr-identity-001"
      resource_group_name = "XXXX.-b-rgp-identity-001-eastus"
      virtual_network_id  = "XXXX.-b-vnt-identity-001"

      inputendpoint = {
        #name                     = [private_dns_resolver_id,subnet_id]
        "in"                    = ["XXXX.-b-dpr-identity-001","XXXX.-b-sub-identity-dprin-001"]
      }
      outputendpoint = {
        #name                           = [private_dns_resolver_id,subnet_id]
        "on-prem-Infoblox-endpoint" = ["XXXX.-b-dpr-identity-001", "XXXX.-b-sub-identity-dprout-001"]
        #"on-prem-Infoblox-endpoint2"     = ["XXXX.-b-dpr-identity-001","XXXX.-b-sub-identity-dprin-001"]
      }
      forwardingruleset = {
        #name                                       =   [rg, out_ep_id]
        "XXXX.-b-frs-identity-001" = ["XXXX.-b-rgp-identity-001-eastus", "on-prem-Infoblox-endpoint"]
      }
      forwardingrule = {
        #vnet_name                      =   [dns_forwarding_ruleset_id, domain_name]
        "rule1" = ["XXXX.-b-frs-identity-001", "sce.eix.com."]
        "rule2" = ["XXXX.-b-frs-identity-001", "edisonconnect.com."]
        "rule3" = ["XXXX.-b-frs-identity-001", "edison.com."]
        "rule4" = ["XXXX.-b-frs-identity-001", "wano.org."]
        "rule5" = ["XXXX.-b-frs-identity-001", "inpo.org."]
        "rule6" = ["XXXX.-b-frs-identity-001", "zscet.net."]
        "rule7" = ["XXXX.-b-frs-identity-001", "z2scet.net."]
        "rule8" = ["XXXX.-b-frs-identity-001", "eixt.com."]
        "rule9" = ["XXXX.-b-frs-identity-001", "z2sce.net."]
        "rule10" = ["XXXX.-b-frs-identity-001", "zsce.net."]
        "rule11" = ["XXXX.-b-frs-identity-001", "southerncaliforniaedison.com."]
        "rule12" = ["XXXX.-b-frs-identity-001", "edisoninvestor.com."]
        "rule13" = ["XXXX.-b-frs-identity-001", "songscommunity.com."]
        "rule14" = ["XXXX.-b-frs-identity-001", "edisoncareers.com."]
        "rule15" = ["XXXX.-b-frs-identity-001", "appserviceenvironment.net."]
        "rule16" = ["XXXX.-b-frs-identity-001", "azure-api.net."]
        "rule17" = ["XXXX.-b-frs-identity-001", "vault.azure.net."]
        "rule18" = ["XXXX.-b-frs-identity-001", "aws-sce.com."]
        "rule19" = ["XXXX.-b-frs-identity-001", "nsce.com."]
        "rule20" = ["XXXX.-b-frs-identity-001", "sce.com."]
        "rule21" = ["XXXX.-b-frs-identity-001", "myedison.net."]
        "rule22" = ["XXXX.-b-frs-identity-001", "myedison.com."]
        "rule23" = ["XXXX.-b-frs-identity-001", "edisonx.com."]
        "rule24" = ["XXXX.-b-frs-identity-001", "edisonintlt.com."]
        "rule25" = ["XXXX.-b-frs-identity-001", "edisonintlapps.com."]
        "rule26" = ["XXXX.-b-frs-identity-001", "edisonintl.com."]
        "rule27" = ["XXXX.-b-frs-identity-001", "googleapis.com."]
        "rule28" = ["XXXX.-b-frs-identity-001", "."]
      }
      dpr_virtual_network_link = {
        #vnet_name                      =  dns_forwarding_ruleset_id
        "XXXX.-b-vnt-connectivity-001"  = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
        "XXXX.-b-vnt-identity-001"      = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
        "XXXX.-b-vnt-automation-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
        "XXXX.-b-vnt-management-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
        "XXXX.-b-vnt-monitoring-001"    = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
        "XXXX.-b-vnt-cybersecurity-001" = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/XXXX.-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/XXXX.-b-frs-identity-001"
      }
    }

    virtual_network = {

      "XXXX.-b-vnt-connectivity-001" = {
        address_space       = ["10.133.4.0/24"]
        resource_group_name = "XXXX.-b-rgp-connectivity-001-eastus"
      }

      "XXXX.-b-vnt-identity-001" = {
        address_space       = ["10.133.10.0/24"]
        resource_group_name = "XXXX.-b-rgp-identity-001-eastus"
      }
      "XXXX.-b-vnt-management-001" = {
        address_space       = ["10.133.8.0/24"]
        resource_group_name = "XXXX.-b-rgp-management-001-eastus"
      }
      "XXXX.-b-vnt-automation-001" = {
        address_space       = ["10.133.9.0/24"]
        resource_group_name = "XXXX.-b-rgp-automation-001-eastus"
      }
      "XXXX.-b-vnt-cybersecurity-001" = {
        address_space       = ["10.133.12.0/24"]
        resource_group_name = "XXXX.-b-rgp-cybersecurity-001-eastus"
      }
      "XXXX.-b-vnt-monitoring-001" = {
        address_space       = ["10.133.11.0/24"]
        resource_group_name = "XXXX.-b-rgp-monitoring-001-eastus"
      }

    }

    subnet = {
      #  addr Prefix = [vnet name,subnet name] 

      "XXXX.-b-sub-connectivity-pe-001"  = ["XXXX.-b-vnt-connectivity-001", "10.133.4.240/28"]
      "XXXX.-b-sub-management-agw-001"   = ["XXXX.-b-vnt-management-001", "10.133.8.0/26"]
      "XXXX.-b-sub-management-agw-int-001" = ["XXXX.-b-vnt-management-001", "10.133.8.128/27"]
      "XXXX.-b-sub-management-agw-ext-001" = ["XXXX.-b-vnt-management-001", "10.133.8.160/27"]
      "XXXX.-b-sub-management-pe-001"    = ["XXXX.-b-vnt-management-001", "10.133.8.240/28"]
      "XXXX.-b-sub-automation-pe-001"    = ["XXXX.-b-vnt-automation-001", "10.133.9.240/28"]
      "XXXX.-b-sub-identity-dprout-001"  = ["XXXX.-b-vnt-identity-001", "10.133.10.0/26"]
      "XXXX.-b-sub-identity-dprin-001"   = ["XXXX.-b-vnt-identity-001", "10.133.10.64/26"]
      "XXXX.-b-sub-identity-rodc-001"    = ["XXXX.-b-vnt-identity-001", "10.133.10.192/27"]
      "XXXX.-b-sub-identity-pe-001"      = ["XXXX.-b-vnt-identity-001", "10.133.10.240/28"]
      "XXXX.-b-sub-monitoring-pe-001"    = ["XXXX.-b-vnt-monitoring-001", "10.133.11.240/28"]
      "XXXX.-b-sub-cybersecurity-pe-001" = ["XXXX.-b-vnt-cybersecurity-001", "10.133.12.240/28"]

    }

    nsg = {
      #  nsg_name = rg name

      "XXXX.-b-nsg-identity-dprout-001" = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-nsg-identity-dprin-001"  = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-nsg-identity-rodc-001"   = "XXXX.-b-rgp-identity-001-eastus"


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


    }

    nsgrule1 = {
      #temporary rules
      # "ia0100nsg-snet-lbs-01" = ["AllowP2SvpnTraffic", "Tcp", ["3389", "80"], ["10.5.3.64/26"], ["10.5.2.128/26", "10.5.2.192/26"]]
      # "id4096nsg-snet-lbs-01" = ["Deny_All", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.-p-nsg-identity-dprout-001" = ["XXXX.-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]
      #"id4096XXXX.-p-nsg-identity-dprin-001" = ["XXXX.-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

      #"ia0110XXXX.-b-nsg-identity-rodc-001" = ["XXXX.-ngr-iba-tcp-100", "Tcp", ["0-65535"], "AzureLoadBalancer", "10.130.10.192/27"]
      #"oa0300XXXX.-b-nsg-identity-rodc-001" = ["XXXX.-ngr-oba-tcp-300", "Tcp", ["3389"], ["172.25.104.19", "172.25.104.20"], ["10.130.10.192/27"]]
      #"id4096XXXX.-b-nsg-identity-rodc-001"  = ["XXXX.-ngr-ibd-any-4096", "*", ["1-65535"], ["0.0.0.0/0"], ["0.0.0.0/0"]]

    }

    nsg-subnet-assoc = {
      #       nsg name = subnet name to link


      "XXXX.-b-nsg-identity-dprout-001" = "XXXX.-b-sub-identity-dprout-001"
      "XXXX.-b-nsg-identity-dprin-001"  = "XXXX.-b-sub-identity-dprin-001"
      "XXXX.-b-nsg-identity-rodc-001"   = "XXXX.-b-sub-identity-rodc-001"

    }

    route_table = {
      #  rt name = rg name

      /*"XXXX.-b-rot-connectivity-pe-001"  = "XXXX.-b-rgp-connectivity-001-eastus"
      "XXXX.-b-rot-management-agw-001"   = "XXXX.-b-rgp-management-001-eastus"
      "XXXX.-b-rot-management-pe-001"    = "XXXX.-b-rgp-management-001-eastus"
      "XXXX.-b-rot-automation-pe-001"    = "XXXX.-b-rgp-automation-001-eastus"
      "XXXX.-b-rot-identity-dprout-001"  = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-rot-identity-dprin-001"   = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-rot-identity-rodc-001"    = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-rot-identity-pe-001"      = "XXXX.-b-rgp-identity-001-eastus"
      "XXXX.-b-rot-monitoring-pe-001"    = "XXXX.-b-rgp-monitoring-001-eastus"
      "XXXX.-b-rot-cybersecurity-pe-001" = "XXXX.-b-rgp-cybersecurity-001-eastus"*/

    }

    udr = {
      #  index = route name, rt Name, AddressSpace, next_hop_type, , next_hop_addr
      #0001 = ["default", "rt-ntw-q2-poc", "0.0.0.0/0", "VirtualAppliance", "10.5.0.132"]
      #0401 = ["default", "rt-apg-ntw-q2-poc", "0.0.0.0/0","Internet"]
      /*1  = ["XXXX.-b-udr-fw-rotconnectivitype", "XXXX.-b-rot-connectivity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      2  = ["XXXX.-b-udr-fw-rotmanagementagw", "XXXX.-b-rot-management-agw-001", "0.0.0.0/0", "Internet"]
      3  = ["XXXX.-b-udr-fw-rotmanagementpe", "XXXX.-b-rot-management-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      4  = ["XXXX.-b-udr-fw-rotautomationpe", "XXXX.-b-rot-automation-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      5  = ["XXXX.-b-udr-fw-rotidentitydprout", "XXXX.-b-rot-identity-dprout-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      6  = ["XXXX.-b-udr-fw-rotidentitydprin", "XXXX.-b-rot-identity-dprin-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      7  = ["XXXX.-b-udr-fw-rotidentitype", "XXXX.-b-rot-identity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      8  = ["XXXX.-b-udr-fw-rotidentityrodc", "XXXX.-b-rot-identity-rodc-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      9  = ["XXXX.-b-udr-fw-rotmonitoringpe", "XXXX.-b-rot-monitoring-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
      10 = ["XXXX.-b-udr-fw-rotcybersecuritype", "XXXX.-b-rot-cybersecurity-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.133.0.228"]
*/
    }

    rt_assoc = {
      # "subnet1" = "rt-apg-ntw-q2-poc" 

      /*"XXXX.-b-rot-connectivity-pe-001"  = "XXXX.-b-sub-connectivity-pe-001"
      "XXXX.-b-rot-management-agw-001"   = "XXXX.-b-sub-management-agw-001"
      "XXXX.-b-rot-management-pe-001"    = "XXXX.-b-sub-management-pe-001"
      "XXXX.-b-rot-automation-pe-001"    = "XXXX.-b-sub-automation-pe-001"
      "XXXX.-b-rot-identity-dprout-001"  = "XXXX.-b-sub-identity-dprout-001"
      "XXXX.-b-rot-identity-dprin-001"   = "XXXX.-b-sub-identity-dprin-001"
      "XXXX.-b-rot-identity-rodc-001"    = "XXXX.-b-sub-identity-rodc-001"
      "XXXX.-b-rot-identity-pe-001"      = "XXXX.-b-sub-identity-pe-001"
      "XXXX.-b-rot-monitoring-pe-001"    = "XXXX.-b-sub-monitoring-pe-001"
      "XXXX.-b-rot-cybersecurity-pe-001" = "XXXX.-b-sub-cybersecurity-pe-001"
*/
    }

  }

}
