locals {

  vhub_id    = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-p-rgp-connectivity-001/providers/Microsoft.Network/virtualHubs/scem-p-vhb-connectivity-001"
  drvhub_id  = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-b-rgp-connectivity-001-eastus/providers/Microsoft.Network/virtualHubs/scem-b-vhb-connectivity-001-eastus"
  dpr-link   = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/scem-p-rgp-identity-001/providers/Microsoft.Network/dnsForwardingRulesets/scem-p-frs-identity-001"
  drdpr-link = "/subscriptions/4c33902a-6c25-48a3-b6bc-aa32895ce5ef/resourceGroups/scem-b-rgp-identity-001-eastus/providers/Microsoft.Network/dnsForwardingRulesets/scem-b-frs-identity-001"
  app = {
    mic = {

      rg = {
        "scem-p-rgp-mic-001" = "West US 3"
      }
      hubpeers = ["scem-p-vnt-mic-001"]

      dpr_virtual_network_link = ["scem-p-vnt-mic-001"]

      virtual_network = {
        "scem-p-vnt-mic-001" = {
          address_space       = ["10.130.35.0/26"]
          resource_group_name = "scem-p-rgp-mic-001"
        }

      }
      subnet = {
        "scem-p-sub-mic-app-001" = ["scem-p-vnt-mic-001", "10.130.35.0/28"]
        "scem-p-sub-mic-db-001"  = ["scem-p-vnt-mic-001", "10.130.35.16/28"]
        "scem-p-sub-mic-web-001" = ["scem-p-vnt-mic-001", "10.130.35.32/28"]
        "scem-p-sub-mic-pe-001"  = ["scem-p-vnt-mic-001", "10.130.35.48/28"]
      }
      nsg = {
        "scem-p-nsg-mic-app-001" = "scem-p-rgp-mic-001"
        "scem-p-nsg-mic-web-001" = "scem-p-rgp-mic-001"
        "scem-p-nsg-mic-db-001"  = "scem-p-rgp-mic-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-mic-app-001" = "scem-p-sub-mic-app-001"
        "scem-p-nsg-mic-db-001"  = "scem-p-sub-mic-db-001"
        "scem-p-nsg-mic-web-001" = "scem-p-sub-mic-web-001"
      }
      route_table = {
        /*"scem-p-rot-mic-app-001" = "scem-p-rgp-mic-001"
                      "scem-p-rot-mic-db-001"  = "scem-p-rgp-mic-001"
                      "scem-p-rot-mic-web-001" = "scem-p-rgp-mic-001"
                      "scem-p-rot-mic-pe-001"  = "scem-p-rgp-mic-001"*/
      }
      udr = {
        /*12   = ["scem-p-udr-fw-rotmicapp", "scem-p-rot-mic-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      201  = ["scem-p-udr-fw-rotmicdb", "scem-p-rot-mic-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      401  = ["scem-p-udr-fw-rotmicweb", "scem-p-rot-mic-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      2401 = ["scem-p-udr-fw-rotmicpe", "scem-p-rot-mic-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-mic-app-001" = "scem-p-sub-mic-app-001"
                      "scem-p-rot-mic-db-001"  = "scem-p-sub-mic-db-001"
                      "scem-p-rot-mic-web-001" = "scem-p-sub-mic-web-001"
                      "scem-p-rot-mic-pe-001"  = "scem-p-sub-mic-pe-001"*/
      }
    }
    apg = {

      rg = {
        "scem-p-rgp-apg-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-apg-001"]

      dpr_virtual_network_link = ["scem-p-vnt-apg-001"]

      virtual_network = {
        "scem-p-vnt-apg-001" = {
          address_space       = ["10.130.17.0/26"]
          resource_group_name = "scem-p-rgp-apg-001"
        }

      }
      subnet = {
        "scem-p-sub-apg-app-001" = ["scem-p-vnt-apg-001", "10.130.17.0/28"]
        "scem-p-sub-apg-db-001"  = ["scem-p-vnt-apg-001", "10.130.17.16/28"]
        "scem-p-sub-apg-web-001" = ["scem-p-vnt-apg-001", "10.130.17.32/28"]
        "scem-p-sub-apg-pe-001"  = ["scem-p-vnt-apg-001", "10.130.17.48/28"]
      }
      nsg = {
        "scem-p-nsg-apg-app-001" = "scem-p-rgp-apg-001"
        "scem-p-nsg-apg-web-001" = "scem-p-rgp-apg-001"
        "scem-p-nsg-apg-db-001"  = "scem-p-rgp-apg-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-apg-app-001" = "scem-p-sub-apg-app-001"
        "scem-p-nsg-apg-db-001"  = "scem-p-sub-apg-db-001"
        "scem-p-nsg-apg-web-001" = "scem-p-sub-apg-web-001"
      }
      route_table = {
        /* "scem-p-rot-apg-app-001" = "scem-p-rgp-apg-001"
                      "scem-p-rot-apg-db-001"  = "scem-p-rgp-apg-001"
                      "scem-p-rot-apg-web-001" = "scem-p-rgp-apg-001"
                      "scem-p-rot-apg-pe-001"  = "scem-p-rgp-apg-001"*/
      }
      udr = {
        /*12   = ["scem-p-udr-fw-rotapgapp", "scem-p-rot-apg-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      201  = ["scem-p-udr-fw-rotapgdb", "scem-p-rot-apg-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      401  = ["scem-p-udr-fw-rotapgweb", "scem-p-rot-apg-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                      2401 = ["scem-p-udr-fw-rotapgpe", "scem-p-rot-apg-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-apg-app-001" = "scem-p-sub-apg-app-001"
                      "scem-p-rot-apg-db-001"  = "scem-p-sub-apg-db-001"
                      "scem-p-rot-apg-web-001" = "scem-p-sub-apg-web-001"
                      "scem-p-rot-apg-pe-001"  = "scem-p-sub-apg-pe-001"*/
      }

    }

    ase = {
      rg = {
        "scem-p-rgp-ase-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-ase-001"]

      dpr_virtual_network_link = ["scem-p-vnt-ase-001"]

      virtual_network = {
        "scem-p-vnt-ase-001" = {
          address_space       = ["10.130.18.0/26"]
          resource_group_name = "scem-p-rgp-ase-001"
        }
      }
      subnet = {
        "scem-p-sub-ase-app-001" = ["scem-p-vnt-ase-001", "10.130.18.0/28"]
        "scem-p-sub-ase-db-001"  = ["scem-p-vnt-ase-001", "10.130.18.16/28"]
        "scem-p-sub-ase-web-001" = ["scem-p-vnt-ase-001", "10.130.18.32/28"]
        "scem-p-sub-ase-pe-001"  = ["scem-p-vnt-ase-001", "10.130.18.48/28"]
      }
      nsg = {
        "scem-p-nsg-ase-app-001" = "scem-p-rgp-ase-001"
        "scem-p-nsg-ase-web-001" = "scem-p-rgp-ase-001"
        "scem-p-nsg-ase-db-001"  = "scem-p-rgp-ase-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-ase-app-001" = "scem-p-sub-ase-app-001"
        "scem-p-nsg-ase-db-001"  = "scem-p-sub-ase-db-001"
        "scem-p-nsg-ase-web-001" = "scem-p-sub-ase-web-001"
      }
      route_table = {
        /*"scem-p-rot-ase-app-001" = "scem-p-rgp-ase-001"
                    "scem-p-rot-ase-db-001"  = "scem-p-rgp-ase-001"
                    "scem-p-rot-ase-web-001" = "scem-p-rgp-ase-001"
                    "scem-p-rot-ase-pe-001"  = "scem-p-rgp-ase-001"*/
      }
      udr = {
        /* 13 = ["scem-p-udr-fw-rotaseapp","scem-p-rot-ase-app-001","0.0.0.0/0","VirtualAppliance","10.130.0.228"]	
                    202 = ["scem-p-udr-fw-rotasedb","scem-p-rot-ase-db-001","0.0.0.0/0","VirtualAppliance","10.130.0.228"]	
                    402 = ["scem-p-udr-fw-rotaseweb","scem-p-rot-ase-web-001","0.0.0.0/0","VirtualAppliance","10.130.0.228"]
                    2402 = ["scem-p-udr-fw-rotasepe","scem-p-rot-ase-pe-001","0.0.0.0/0","VirtualAppliance","10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-ase-app-001" = "scem-p-sub-ase-app-001"
                    "scem-p-rot-ase-db-001"  = "scem-p-sub-ase-db-001"
                    "scem-p-rot-ase-web-001" = "scem-p-sub-ase-web-001"
                    "scem-p-rot-ase-pe-001"  = "scem-p-sub-ase-pe-001"*/
      }

    }

    emp = {

      rg = {
        "scem-p-rgp-emp-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-emp-001"]

      dpr_virtual_network_link = ["scem-p-vnt-emp-001"]

      virtual_network = {
        "scem-p-vnt-emp-001" = {
          address_space       = ["10.130.20.0/26"]
          resource_group_name = "scem-p-rgp-emp-001"
        }
      }
      subnet = {
        "scem-p-sub-emp-app-001" = ["scem-p-vnt-emp-001", "10.130.20.0/28"]
        "scem-p-sub-emp-db-001"  = ["scem-p-vnt-emp-001", "10.130.20.16/28"]
        "scem-p-sub-emp-web-001" = ["scem-p-vnt-emp-001", "10.130.20.32/28"]
        "scem-p-sub-emp-pe-001"  = ["scem-p-vnt-emp-001", "10.130.20.48/28"]
      }
      nsg = {
        "scem-p-nsg-emp-app-001" = "scem-p-rgp-emp-001"
        "scem-p-nsg-emp-web-001" = "scem-p-rgp-emp-001"
        "scem-p-nsg-emp-db-001"  = "scem-p-rgp-emp-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-emp-app-001" = "scem-p-sub-emp-app-001"
        "scem-p-nsg-emp-db-001"  = "scem-p-sub-emp-db-001"
        "scem-p-nsg-emp-web-001" = "scem-p-sub-emp-web-001"
      }
      route_table = {
        /*"scem-p-rot-emp-app-001" = "scem-p-rgp-emp-001"
                    "scem-p-rot-emp-db-001"  = "scem-p-rgp-emp-001"
                    "scem-p-rot-emp-web-001" = "scem-p-rgp-emp-001"
                    "scem-p-rot-emp-pe-001"  = "scem-p-rgp-emp-001"*/
      }
      udr = {
        /*15   = ["scem-p-udr-fw-rotempapp", "scem-p-rot-emp-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    204  = ["scem-p-udr-fw-rotempdb", "scem-p-rot-emp-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    404  = ["scem-p-udr-fw-rotempweb", "scem-p-rot-emp-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2104 = ["scem-p-udr-fw-rotemppe", "scem-p-rot-emp-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-emp-app-001" = "scem-p-sub-emp-app-001"
                    "scem-p-rot-emp-db-001"  = "scem-p-sub-emp-db-001"
                    "scem-p-rot-emp-web-001" = "scem-p-sub-emp-web-001"
                    "scem-p-rot-emp-pe-001"  = "scem-p-sub-emp-pe-001"*/
      }

    }

    nar = {

      rg = {
        "scem-p-rgp-nar-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-nar-001"]

      dpr_virtual_network_link = ["scem-p-vnt-nar-001"]

      virtual_network = {
        "scem-p-vnt-nar-001" = {
          address_space       = ["10.130.21.0/26"]
          resource_group_name = "scem-p-rgp-nar-001"
        }
      }
      subnet = {
        "scem-p-sub-nar-app-001" = ["scem-p-vnt-nar-001", "10.130.21.0/28"]
        "scem-p-sub-nar-db-001"  = ["scem-p-vnt-nar-001", "10.130.21.16/28"]
        "scem-p-sub-nar-web-001" = ["scem-p-vnt-nar-001", "10.130.21.32/28"]
        "scem-p-sub-nar-pe-001"  = ["scem-p-vnt-nar-001", "10.130.21.48/28"]
      }
      nsg = {
        "scem-p-nsg-nar-app-001" = "scem-p-rgp-nar-001"
        "scem-p-nsg-nar-web-001" = "scem-p-rgp-nar-001"
        "scem-p-nsg-nar-db-001"  = "scem-p-rgp-nar-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-nar-app-001" = "scem-p-sub-nar-app-001"
        "scem-p-nsg-nar-db-001"  = "scem-p-sub-nar-db-001"
        "scem-p-nsg-nar-web-001" = "scem-p-sub-nar-web-001"
      }
      route_table = {
        /*"scem-p-rot-nar-app-001" = "scem-p-rgp-nar-001"
                    "scem-p-rot-nar-db-001"  = "scem-p-rgp-nar-001"
                    "scem-p-rot-nar-web-001" = "scem-p-rgp-nar-001"
                    "scem-p-rot-nar-pe-001"  = "scem-p-rgp-nar-001"*/
      }
      udr = {
        /* 16   = ["scem-p-udr-fw-rotnarapp", "scem-p-rot-nar-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    205  = ["scem-p-udr-fw-rotnardb", "scem-p-rot-nar-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    405  = ["scem-p-udr-fw-rotnarweb", "scem-p-rot-nar-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2405 = ["scem-p-udr-fw-rotnarpe", "scem-p-rot-nar-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /* "scem-p-rot-nar-app-001" = "scem-p-sub-nar-app-001"
                    "scem-p-rot-nar-db-001"  = "scem-p-sub-nar-db-001"
                    "scem-p-rot-nar-web-001" = "scem-p-sub-nar-web-001"
                    "scem-p-rot-nar-pe-001"  = "scem-p-sub-nar-pe-001"*/
      }

    }

    roc = {

      rg = {
        "scem-p-rgp-roc-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-roc-001"]

      dpr_virtual_network_link = ["scem-p-vnt-roc-001"]

      virtual_network = {
        "scem-p-vnt-roc-001" = {
          address_space       = ["10.130.34.0/26"]
          resource_group_name = "scem-p-rgp-roc-001"
        }
      }
      subnet = {
        "scem-p-sub-roc-app-001"   = ["scem-p-vnt-roc-001", "10.130.34.0/28"]
        "scem-p-sub-roc-pe-001"    = ["scem-p-vnt-roc-001", "10.130.34.16/28"]
        "scem-p-sub-roc-sqlmi-001" = ["scem-p-vnt-roc-001", "10.130.34.32/27"]
        #"scem-p-sub-roc-pe-001"  = ["scem-p-vnt-roc-001", "10.130.34.48/28"]
      }
      nsg = {
        "scem-p-nsg-roc-app-001" = "scem-p-rgp-roc-001"
        #"scem-p-nsg-roc-web-001" = "scem-p-rgp-roc-001"
        "scem-p-nsg-roc-db-001" = "scem-p-rgp-roc-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-roc-app-001" = "scem-p-sub-roc-app-001"
        "scem-p-nsg-roc-db-001"  = "scem-p-sub-roc-sqlmi-001"
        #"scem-p-nsg-roc-web-001" = "scem-p-sub-roc-web-001"
      }
      route_table = {
        #"scem-p-rot-roc-app-001" = "scem-p-rgp-roc-001"
        "scem-p-rot-roc-db-001" = "scem-p-rgp-roc-001"
        #"scem-p-rot-roc-web-001" = "scem-p-rgp-roc-001"
        #"scem-p-rot-roc-pe-001"  = "scem-p-rgp-roc-001"
      }
      udr = {
        #17   = ["scem-p-udr-fw-rotrocapp", "scem-p-rot-roc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        206 = ["scem-p-udr-fw-rotrocdb", "scem-p-rot-roc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        #406 = ["scem-p-udr-fw-rotrocweb", "scem-p-rot-roc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        #2406 = ["scem-p-udr-fw-rotrocpe", "scem-p-rot-roc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      }
      rt_assoc = {
        #"scem-p-rot-roc-app-001" = "scem-p-sub-roc-app-001"
        "scem-p-rot-roc-db-001" = "scem-p-sub-roc-sqlmi-001"
        #"scem-p-rot-roc-web-001" = "scem-p-sub-roc-web-001"
        #"scem-p-rot-roc-pe-001"  = "scem-p-sub-roc-pe-001"
      }

    }

    sca = {

      rg = {
        "scem-p-rgp-sca-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-sca-001"]

      dpr_virtual_network_link = ["scem-p-vnt-sca-001"]

      virtual_network = {
        "scem-p-vnt-sca-001" = {
          address_space       = ["10.130.24.0/26"]
          resource_group_name = "scem-p-rgp-sca-001"
        }
      }
      subnet = {
        "scem-p-sub-sca-app-001" = ["scem-p-vnt-sca-001", "10.130.24.0/28"]
        "scem-p-sub-sca-db-001"  = ["scem-p-vnt-sca-001", "10.130.24.16/28"]
        "scem-p-sub-sca-web-001" = ["scem-p-vnt-sca-001", "10.130.24.32/28"]
        "scem-p-sub-sca-pe-001"  = ["scem-p-vnt-sca-001", "10.130.24.48/28"]
      }
      nsg = {
        "scem-p-nsg-sca-app-001" = "scem-p-rgp-sca-001"
        "scem-p-nsg-sca-web-001" = "scem-p-rgp-sca-001"
        "scem-p-nsg-sca-db-001"  = "scem-p-rgp-sca-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-sca-app-001" = "scem-p-sub-sca-app-001"
        "scem-p-nsg-sca-db-001"  = "scem-p-sub-sca-db-001"
        "scem-p-nsg-sca-web-001" = "scem-p-sub-sca-web-001"
      }
      route_table = {
        /*"scem-p-rot-sca-app-001" = "scem-p-rgp-sca-001"
                    "scem-p-rot-sca-db-001"  = "scem-p-rgp-sca-001"
                    "scem-p-rot-sca-web-001" = "scem-p-rgp-sca-001"
                    "scem-p-rot-sca-pe-001"  = "scem-p-rgp-sca-001"*/
      }
      udr = {
        /*19   = ["scem-p-udr-fw-rotscaapp", "scem-p-rot-sca-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    208  = ["scem-p-udr-fw-rotscadb", "scem-p-rot-sca-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    408  = ["scem-p-udr-fw-rotscaweb", "scem-p-rot-sca-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2408 = ["scem-p-udr-fw-rotscape", "scem-p-rot-sca-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-sca-app-001" = "scem-p-sub-sca-app-001"
                    "scem-p-rot-sca-db-001"  = "scem-p-sub-sca-db-001"
                    "scem-p-rot-sca-web-001" = "scem-p-sub-sca-web-001"
                    "scem-p-rot-sca-pe-001"  = "scem-p-sub-sca-pe-001"*/
      }

    }
    wsm = {

      rg = {
        "scem-p-rgp-wsm-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-wsm-001"]

      dpr_virtual_network_link = ["scem-p-vnt-wsm-001"]

      virtual_network = {
        "scem-p-vnt-wsm-001" = {
          address_space       = ["10.130.25.0/26"]
          resource_group_name = "scem-p-rgp-wsm-001"
        }
      }
      subnet = {
        "scem-p-sub-wsm-app-001"   = ["scem-p-vnt-wsm-001", "10.130.25.0/28"]
        "scem-p-sub-wsm-pe-001"    = ["scem-p-vnt-wsm-001", "10.130.25.16/28"]
        "scem-p-sub-wsm-sqlmi-001" = ["scem-p-vnt-wsm-001", "10.130.25.32/27"]
        #"scem-p-sub-wsm-pe-001"  = ["scem-p-vnt-wsm-001", "10.130.25.48/28"]
      }
      nsg = {
        "scem-p-nsg-wsm-app-001" = "scem-p-rgp-wsm-001"
        #"scem-p-nsg-wsm-web-001" = "scem-p-rgp-wsm-001"
        "scem-p-nsg-wsm-db-001" = "scem-p-rgp-wsm-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-wsm-app-001" = "scem-p-sub-wsm-app-001"
        "scem-p-nsg-wsm-db-001"  = "scem-p-sub-wsm-sqlmi-001"
        #"scem-p-nsg-wsm-web-001" = "scem-p-sub-wsm-web-001"
      }
      route_table = {
        #"scem-p-rot-wsm-app-001" = "scem-p-rgp-wsm-001"
        "scem-p-rot-wsm-db-001" = "scem-p-rgp-wsm-001"
        #"scem-p-rot-wsm-web-001" = "scem-p-rgp-wsm-001"
        #"scem-p-rot-wsm-pe-001"  = "scem-p-rgp-wsm-001"
      }
      udr = {
        #27   = ["scem-p-udr-fw-rotwsmapp", "scem-p-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        216 = ["scem-p-udr-fw-rotwsmdb", "scem-p-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        #416  = ["scem-p-udr-fw-rotwsmweb", "scem-p-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        #2416 = ["scem-p-udr-fw-rotwsmpe", "scem-p-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
      }
      rt_assoc = {
        #"scem-p-rot-wsm-app-001" = "scem-p-sub-wsm-app-001"
        "scem-p-rot-wsm-db-001" = "scem-p-sub-wsm-sqlmi-001"
        #"scem-p-rot-wsm-web-001" = "scem-p-sub-wsm-web-001"
        #"scem-p-rot-wsm-pe-001"  = "scem-p-sub-wsm-pe-001"
      }

    }
    wtr = {

      rg = {
        "scem-p-rgp-wtr-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-wtr-001"]

      dpr_virtual_network_link = ["scem-p-vnt-wtr-001"]

      virtual_network = {
        "scem-p-vnt-wtr-001" = {
          address_space       = ["10.130.26.0/26"]
          resource_group_name = "scem-p-rgp-wtr-001"
        }
      }
      subnet = {
        "scem-p-sub-wtr-app-001" = ["scem-p-vnt-wtr-001", "10.130.26.0/28"]
        "scem-p-sub-wtr-db-001"  = ["scem-p-vnt-wtr-001", "10.130.26.16/28"]
        "scem-p-sub-wtr-web-001" = ["scem-p-vnt-wtr-001", "10.130.26.32/28"]
        "scem-p-sub-wtr-pe-001"  = ["scem-p-vnt-wtr-001", "10.130.26.48/28"]
      }
      nsg = {
        "scem-p-nsg-wtr-app-001" = "scem-p-rgp-wtr-001"
        "scem-p-nsg-wtr-web-001" = "scem-p-rgp-wtr-001"
        "scem-p-nsg-wtr-db-001"  = "scem-p-rgp-wtr-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-wtr-app-001" = "scem-p-sub-wtr-app-001"
        "scem-p-nsg-wtr-db-001"  = "scem-p-sub-wtr-db-001"
        "scem-p-nsg-wtr-web-001" = "scem-p-sub-wtr-web-001"
      }
      route_table = {
        /*"scem-p-rot-wtr-app-001" = "scem-p-rgp-wtr-001"
                    "scem-p-rot-wtr-db-001"  = "scem-p-rgp-wtr-001"
                    "scem-p-rot-wtr-web-001" = "scem-p-rgp-wtr-001"
                    "scem-p-rot-wtr-pe-001"  = "scem-p-rgp-wtr-001"*/
      }
      udr = {
        /*21   = ["scem-p-udr-fw-rotwtrapp", "scem-p-rot-wtr-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    210  = ["scem-p-udr-fw-rotwtrdb", "scem-p-rot-wtr-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    410  = ["scem-p-udr-fw-rotwtrweb", "scem-p-rot-wtr-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2410 = ["scem-p-udr-fw-rotwtrpe", "scem-p-rot-wtr-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-wtr-app-001" = "scem-p-sub-wtr-app-001"
                    "scem-p-rot-wtr-db-001"  = "scem-p-sub-wtr-db-001"
                    "scem-p-rot-wtr-web-001" = "scem-p-sub-wtr-web-001"
                    "scem-p-rot-wtr-pe-001"  = "scem-p-sub-wtr-pe-001"*/
      }

    }

    appservice = {
      rg = {
        "scem-p-rgp-cma_appservice-001"  = "West US 3"
        "scem-p-rgp-emp-001appservice"   = "West US 3"
        "scem-p-rgp-wtr-001appservice"   = "West US 3"
        "scem-p-rgp-WUS3_appservice-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-WUS3_appservice-001"] #"scem-p-vnt-cma_appservice-001"

      dpr_virtual_network_link = ["scem-p-vnt-WUS3_appservice-001"] #"scem-p-vnt-cma_appservice-001"

      virtual_network = {
        /* "scem-p-vnt-cma_appservice-001" = {
                      address_space       = ["10.130.36.0/24","10.130.31.32/28"]
                      resource_group_name = "scem-p-rgp-cma_appservice-001"
                    },*/
        "scem-p-vnt-WUS3_appservice-001" = {
          address_space       = ["10.130.36.0/24", "10.130.31.32/28"]
          resource_group_name = "scem-p-rgp-WUS3_appservice-001"
        }
      }
      subnet = {
        #"scem-p-sub-cma_appservice-001" = ["scem-p-vnt-cma_appservice-001", "10.130.36.0/24"]
        #"scem-p-sub-cma_appservice_pe-001" = ["scem-p-vnt-cma_appservice-001", "10.130.31.32/28"]
        "scem-p-sub-WUS3_appservice-001"    = ["scem-p-vnt-WUS3_appservice-001", "10.130.36.0/24"]
        "scem-p-sub-WUS3_appservice-pe-001" = ["scem-p-vnt-WUS3_appservice-001", "10.130.31.32/28"]
      }
      nsg = {
        #"scem-p-nsg-cma_appservice-001" = "scem-p-rgp-cma_appservice-001"
        "scem-p-nsg-WUS3_appservice-001" = "scem-p-rgp-WUS3_appservice-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        #"scem-p-nsg-cma_appservice-001" = "scem-p-sub-cma_appservice-001"
        "scem-p-nsg-WUS3_appservice-001" = "scem-p-sub-WUS3_appservice-001"
      }

    }

    jks = {

      rg = {
        "scem-p-rgp-jks-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-jks-001"]

      dpr_virtual_network_link = ["scem-p-vnt-jks-001"]

      virtual_network = {
        "scem-p-vnt-jks-001" = {
          address_space       = ["10.130.32.0/26", "10.130.31.16/28"]
          resource_group_name = "scem-p-rgp-jks-001"
        }
      }
      subnet = {
        "scem-p-sub-jks-app-001" = ["scem-p-vnt-jks-001", "10.130.32.0/27"]
        "scem-p-sub-jks-db-001"  = ["scem-p-vnt-jks-001", "10.130.31.16/28"]
        "scem-p-sub-jks-web-001" = ["scem-p-vnt-jks-001", "10.130.32.32/28"]
        "scem-p-sub-jks-pe-001"  = ["scem-p-vnt-jks-001", "10.130.32.48/28"]
      }
      nsg = {
        "scem-p-nsg-jks-app-001" = "scem-p-rgp-jks-001"
        "scem-p-nsg-jks-web-001" = "scem-p-rgp-jks-001"
        "scem-p-nsg-jks-db-001"  = "scem-p-rgp-jks-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-jks-app-001" = "scem-p-sub-jks-app-001"
        "scem-p-nsg-jks-db-001"  = "scem-p-sub-jks-db-001"
        "scem-p-nsg-jks-web-001" = "scem-p-sub-jks-web-001"
      }
      route_table = {
        /*"scem-p-rot-jks-app-001" = "scem-p-rgp-jks-001"
                    "scem-p-rot-jks-db-001"  = "scem-p-rgp-jks-001"
                    "scem-p-rot-jks-web-001" = "scem-p-rgp-jks-001"
                    "scem-p-rot-jks-pe-001"  = "scem-p-rgp-jks-001"*/
      }
      udr = {
        /*27   = ["scem-p-udr-fw-rotjksapp", "scem-p-rot-jks-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    216  = ["scem-p-udr-fw-rotjksdb", "scem-p-rot-jks-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    416  = ["scem-p-udr-fw-rotjksweb", "scem-p-rot-jks-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2416 = ["scem-p-udr-fw-rotjkspe", "scem-p-rot-jks-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /* "scem-p-rot-jks-app-001" = "scem-p-sub-jks-app-001"
                    "scem-p-rot-jks-db-001"  = "scem-p-sub-jks-db-001"
                    "scem-p-rot-jks-web-001" = "scem-p-sub-jks-web-001"
                    "scem-p-rot-jks-pe-001"  = "scem-p-sub-jks-pe-001"*/
      }

    }
    psw = {

      rg = {
        "scem-p-rgp-psw-001" = "West US 3"
      }

      hubpeers = ["scem-p-vnt-psw-001"]

      dpr_virtual_network_link = ["scem-p-vnt-psw-001"]

      virtual_network = {
        "scem-p-vnt-psw-001" = {
          address_space       = ["10.130.33.0/26"]
          resource_group_name = "scem-p-rgp-psw-001"
        }
      }
      subnet = {
        "scem-p-sub-psw-app-001" = ["scem-p-vnt-psw-001", "10.130.33.0/28"]
        "scem-p-sub-psw-db-001"  = ["scem-p-vnt-psw-001", "10.130.33.16/28"]
        "scem-p-sub-psw-web-001" = ["scem-p-vnt-psw-001", "10.130.33.32/28"]
        "scem-p-sub-psw-pe-001"  = ["scem-p-vnt-psw-001", "10.130.33.48/28"]
      }
      nsg = {
        "scem-p-nsg-psw-app-001" = "scem-p-rgp-psw-001"
        "scem-p-nsg-psw-web-001" = "scem-p-rgp-psw-001"
        "scem-p-nsg-psw-db-001"  = "scem-p-rgp-psw-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-p-nsg-psw-app-001" = "scem-p-sub-psw-app-001"
        "scem-p-nsg-psw-db-001"  = "scem-p-sub-psw-db-001"
        "scem-p-nsg-psw-web-001" = "scem-p-sub-psw-web-001"
      }
      route_table = {
        /*"scem-p-rot-psw-app-001" = "scem-p-rgp-psw-001"
                    "scem-p-rot-psw-db-001"  = "scem-p-rgp-psw-001"
                    "scem-p-rot-psw-web-001" = "scem-p-rgp-psw-001"
                    "scem-p-rot-psw-pe-001"  = "scem-p-rgp-psw-001"*/
      }
      udr = {
        /*27   = ["scem-p-udr-fw-rotpswapp", "scem-p-rot-psw-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    216  = ["scem-p-udr-fw-rotpswdb", "scem-p-rot-psw-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    416  = ["scem-p-udr-fw-rotpswweb", "scem-p-rot-psw-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
                    2416 = ["scem-p-udr-fw-rotpswpe", "scem-p-rot-psw-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-p-rot-psw-app-001" = "scem-p-sub-psw-app-001"
                    "scem-p-rot-psw-db-001"  = "scem-p-sub-psw-db-001"
                    "scem-p-rot-psw-web-001" = "scem-p-sub-psw-web-001"
                    "scem-p-rot-psw-pe-001"  = "scem-p-sub-psw-pe-001"*/
      }

    }

  }
  ##########################################################################################################################
  ##########################################################################################################################
  #                                           NON - PROD Variables
  ##########################################################################################################################
  ##########################################################################################################################


  napp = {
    mic = {
      rg = {
        "scem-d-rgp-mic-001" = "West US 3"
        "scem-f-rgp-mic-001" = "West US 3"
        "scem-q-rgp-mic-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-mic-001"]

      dpr_virtual_network_link = ["scem-d-vnt-mic-001"]

      virtual_network = {
        "scem-d-vnt-mic-001" = {
          address_space       = ["10.130.35.64/26", "10.130.35.128/25"]
          resource_group_name = "scem-d-rgp-mic-001"
        }
      }
      subnet = {
        "scem-d-sub-mic-app-001" = ["scem-d-vnt-mic-001", "10.130.35.64/28"]
        "scem-d-sub-mic-db-001"  = ["scem-d-vnt-mic-001", "10.130.35.80/28"]
        "scem-d-sub-mic-web-001" = ["scem-d-vnt-mic-001", "10.130.35.96/28"]
        "scem-d-sub-mic-pe-001"  = ["scem-d-vnt-mic-001", "10.130.35.112/28"]
        "scem-f-sub-mic-app-001" = ["scem-d-vnt-mic-001", "10.130.35.128/28"]
        "scem-f-sub-mic-db-001"  = ["scem-d-vnt-mic-001", "10.130.35.144/28"]
        "scem-f-sub-mic-web-001" = ["scem-d-vnt-mic-001", "10.130.35.160/28"]
        "scem-f-sub-mic-pe-001"  = ["scem-d-vnt-mic-001", "10.130.35.176/28"]
        "scem-q-sub-mic-app-001" = ["scem-d-vnt-mic-001", "10.130.35.192/28"]
        "scem-q-sub-mic-db-001"  = ["scem-d-vnt-mic-001", "10.130.35.208/28"]
        "scem-q-sub-mic-web-001" = ["scem-d-vnt-mic-001", "10.130.35.224/28"]
        "scem-q-sub-mic-pe-001"  = ["scem-d-vnt-mic-001", "10.130.35.240/28"]
      }
      nsg = {
        "scem-d-nsg-mic-app-001" = "scem-d-rgp-mic-001"
        "scem-d-nsg-mic-web-001" = "scem-d-rgp-mic-001"
        "scem-d-nsg-mic-db-001"  = "scem-d-rgp-mic-001"

        "scem-f-nsg-mic-app-001" = "scem-f-rgp-mic-001"
        "scem-f-nsg-mic-web-001" = "scem-f-rgp-mic-001"
        "scem-f-nsg-mic-db-001"  = "scem-f-rgp-mic-001"

        "scem-q-nsg-mic-app-001" = "scem-q-rgp-mic-001"
        "scem-q-nsg-mic-web-001" = "scem-q-rgp-mic-001"
        "scem-q-nsg-mic-db-001"  = "scem-q-rgp-mic-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-mic-app-001" = "scem-d-sub-mic-app-001"
        "scem-d-nsg-mic-db-001"  = "scem-d-sub-mic-db-001"
        "scem-d-nsg-mic-web-001" = "scem-d-sub-mic-web-001"

        "scem-f-nsg-mic-app-001" = "scem-f-sub-mic-app-001"
        "scem-f-nsg-mic-db-001"  = "scem-f-sub-mic-db-001"
        "scem-f-nsg-mic-web-001" = "scem-f-sub-mic-web-001"

        "scem-q-nsg-mic-app-001" = "scem-q-sub-mic-app-001"
        "scem-q-nsg-mic-db-001"  = "scem-q-sub-mic-db-001"
        "scem-q-nsg-mic-web-001" = "scem-q-sub-mic-web-001"
      }
      route_table = {

        /*"scem-d-rot-mic-app-001" = "scem-d-rgp-mic-001"
          "scem-d-rot-mic-db-001"  = "scem-d-rgp-mic-001"
          "scem-d-rot-mic-web-001" = "scem-d-rgp-mic-001"
          "scem-d-rot-mic-pe-001"  = "scem-d-rgp-mic-001"
          "scem-f-rot-mic-app-001" = "scem-f-rgp-mic-001"
          "scem-f-rot-mic-db-001"  = "scem-f-rgp-mic-001"
          "scem-f-rot-mic-web-001" = "scem-f-rgp-mic-001"
          "scem-f-rot-mic-pe-001"  = "scem-f-rgp-mic-001"
          "scem-q-rot-mic-app-001" = "scem-q-rgp-mic-001"
          "scem-q-rot-mic-db-001"  = "scem-q-rgp-mic-001"
          "scem-q-rot-mic-web-001" = "scem-q-rgp-mic-001"
          "scem-q-rot-mic-pe-001"  = "scem-q-rgp-mic-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotmicapp", "scem-d-rot-mic-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotmicdb", "scem-d-rot-mic-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotmicweb", "scem-d-rot-mic-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotmicapp", "scem-f-rot-mic-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotmicdb", "scem-f-rot-mic-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotmicweb", "scem-f-rot-mic-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotmicapp", "scem-q-rot-mic-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotmicdb", "scem-q-rot-mic-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotmicweb", "scem-q-rot-mic-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotmicpe", "scem-d-rot-mic-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotmicpe", "scem-f-rot-mic-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotmicpe", "scem-q-rot-mic-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-mic-app-001" = "scem-d-sub-mic-app-001"
          "scem-d-rot-mic-db-001"  = "scem-d-sub-mic-db-001"
          "scem-d-rot-mic-web-001" = "scem-d-sub-mic-web-001"
          "scem-d-rot-mic-pe-001"  = "scem-d-sub-mic-pe-001"
          "scem-f-rot-mic-app-001" = "scem-f-sub-mic-app-001"
          "scem-f-rot-mic-db-001"  = "scem-f-sub-mic-db-001"
          "scem-f-rot-mic-web-001" = "scem-f-sub-mic-web-001"
          "scem-f-rot-mic-pe-001"  = "scem-f-sub-mic-pe-001"
          "scem-q-rot-mic-app-001" = "scem-q-sub-mic-app-001"
          "scem-q-rot-mic-db-001"  = "scem-q-sub-mic-db-001"
          "scem-q-rot-mic-web-001" = "scem-q-sub-mic-web-001"
          "scem-q-rot-mic-pe-001"  = "scem-q-sub-mic-pe-001"*/
      }

    }

    apg = {
      rg = {
        "scem-d-rgp-apg-001" = "West US 3"
        "scem-f-rgp-apg-001" = "West US 3"
        "scem-q-rgp-apg-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-apg-001"]

      dpr_virtual_network_link = ["scem-d-vnt-apg-001"]

      virtual_network = {
        "scem-d-vnt-apg-001" = {
          address_space       = ["10.130.17.64/26", "10.130.17.128/25"]
          resource_group_name = "scem-d-rgp-apg-001"
        }
      }
      subnet = {
        "scem-d-sub-apg-app-001" = ["scem-d-vnt-apg-001", "10.130.17.64/28"]
        "scem-d-sub-apg-db-001"  = ["scem-d-vnt-apg-001", "10.130.17.80/28"]
        "scem-d-sub-apg-web-001" = ["scem-d-vnt-apg-001", "10.130.17.96/28"]
        "scem-d-sub-apg-pe-001"  = ["scem-d-vnt-apg-001", "10.130.17.112/28"]
        "scem-f-sub-apg-app-001" = ["scem-d-vnt-apg-001", "10.130.17.128/28"]
        "scem-f-sub-apg-db-001"  = ["scem-d-vnt-apg-001", "10.130.17.144/28"]
        "scem-f-sub-apg-web-001" = ["scem-d-vnt-apg-001", "10.130.17.160/28"]
        "scem-f-sub-apg-pe-001"  = ["scem-d-vnt-apg-001", "10.130.17.176/28"]
        "scem-q-sub-apg-app-001" = ["scem-d-vnt-apg-001", "10.130.17.192/28"]
        "scem-q-sub-apg-db-001"  = ["scem-d-vnt-apg-001", "10.130.17.208/28"]
        "scem-q-sub-apg-web-001" = ["scem-d-vnt-apg-001", "10.130.17.224/28"]
        "scem-q-sub-apg-pe-001"  = ["scem-d-vnt-apg-001", "10.130.17.240/28"]
      }
      nsg = {
        "scem-d-nsg-apg-app-001" = "scem-d-rgp-apg-001"
        "scem-d-nsg-apg-web-001" = "scem-d-rgp-apg-001"
        "scem-d-nsg-apg-db-001"  = "scem-d-rgp-apg-001"

        "scem-f-nsg-apg-app-001" = "scem-f-rgp-apg-001"
        "scem-f-nsg-apg-web-001" = "scem-f-rgp-apg-001"
        "scem-f-nsg-apg-db-001"  = "scem-f-rgp-apg-001"

        "scem-q-nsg-apg-app-001" = "scem-q-rgp-apg-001"
        "scem-q-nsg-apg-web-001" = "scem-q-rgp-apg-001"
        "scem-q-nsg-apg-db-001"  = "scem-q-rgp-apg-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-apg-app-001" = "scem-d-sub-apg-app-001"
        "scem-d-nsg-apg-db-001"  = "scem-d-sub-apg-db-001"
        "scem-d-nsg-apg-web-001" = "scem-d-sub-apg-web-001"

        "scem-f-nsg-apg-app-001" = "scem-f-sub-apg-app-001"
        "scem-f-nsg-apg-db-001"  = "scem-f-sub-apg-db-001"
        "scem-f-nsg-apg-web-001" = "scem-f-sub-apg-web-001"

        "scem-q-nsg-apg-app-001" = "scem-q-sub-apg-app-001"
        "scem-q-nsg-apg-db-001"  = "scem-q-sub-apg-db-001"
        "scem-q-nsg-apg-web-001" = "scem-q-sub-apg-web-001"
      }
      route_table = {

        /*"scem-d-rot-apg-app-001" = "scem-d-rgp-apg-001"
          "scem-d-rot-apg-db-001"  = "scem-d-rgp-apg-001"
          "scem-d-rot-apg-web-001" = "scem-d-rgp-apg-001"
          "scem-d-rot-apg-pe-001"  = "scem-d-rgp-apg-001"
          "scem-f-rot-apg-app-001" = "scem-f-rgp-apg-001"
          "scem-f-rot-apg-db-001"  = "scem-f-rgp-apg-001"
          "scem-f-rot-apg-web-001" = "scem-f-rgp-apg-001"
          "scem-f-rot-apg-pe-001"  = "scem-f-rgp-apg-001"
          "scem-q-rot-apg-app-001" = "scem-q-rgp-apg-001"
          "scem-q-rot-apg-db-001"  = "scem-q-rgp-apg-001"
          "scem-q-rot-apg-web-001" = "scem-q-rgp-apg-001"
          "scem-q-rot-apg-pe-001"  = "scem-q-rgp-apg-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotapgapp", "scem-d-rot-apg-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotapgdb", "scem-d-rot-apg-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotapgweb", "scem-d-rot-apg-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotapgapp", "scem-f-rot-apg-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotapgdb", "scem-f-rot-apg-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotapgweb", "scem-f-rot-apg-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotapgapp", "scem-q-rot-apg-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotapgdb", "scem-q-rot-apg-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotapgweb", "scem-q-rot-apg-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotapgpe", "scem-d-rot-apg-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotapgpe", "scem-f-rot-apg-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotapgpe", "scem-q-rot-apg-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-apg-app-001" = "scem-d-sub-apg-app-001"
          "scem-d-rot-apg-db-001"  = "scem-d-sub-apg-db-001"
          "scem-d-rot-apg-web-001" = "scem-d-sub-apg-web-001"
          "scem-d-rot-apg-pe-001"  = "scem-d-sub-apg-pe-001"
          "scem-f-rot-apg-app-001" = "scem-f-sub-apg-app-001"
          "scem-f-rot-apg-db-001"  = "scem-f-sub-apg-db-001"
          "scem-f-rot-apg-web-001" = "scem-f-sub-apg-web-001"
          "scem-f-rot-apg-pe-001"  = "scem-f-sub-apg-pe-001"
          "scem-q-rot-apg-app-001" = "scem-q-sub-apg-app-001"
          "scem-q-rot-apg-db-001"  = "scem-q-sub-apg-db-001"
          "scem-q-rot-apg-web-001" = "scem-q-sub-apg-web-001"
          "scem-q-rot-apg-pe-001"  = "scem-q-sub-apg-pe-001"*/
      }

    }

    ase = {
      rg = {
        "scem-d-rgp-ase-001" = "West US 3"
        "scem-f-rgp-ase-001" = "West US 3"
        "scem-q-rgp-ase-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-ase-001"]

      dpr_virtual_network_link = ["scem-d-vnt-ase-001"]

      virtual_network = {
        "scem-d-vnt-ase-001" = {
          address_space       = ["10.130.18.64/26", "10.130.18.128/25"]
          resource_group_name = "scem-d-rgp-ase-001"
        }
      }
      subnet = {
        "scem-d-sub-ase-app-001" = ["scem-d-vnt-ase-001", "10.130.18.64/28"]
        "scem-d-sub-ase-db-001"  = ["scem-d-vnt-ase-001", "10.130.18.80/28"]
        "scem-d-sub-ase-web-001" = ["scem-d-vnt-ase-001", "10.130.18.96/28"]
        "scem-d-sub-ase-pe-001"  = ["scem-d-vnt-ase-001", "10.130.18.112/28"]
        "scem-f-sub-ase-app-001" = ["scem-d-vnt-ase-001", "10.130.18.128/28"]
        "scem-f-sub-ase-db-001"  = ["scem-d-vnt-ase-001", "10.130.18.144/28"]
        "scem-f-sub-ase-web-001" = ["scem-d-vnt-ase-001", "10.130.18.160/28"]
        "scem-f-sub-ase-pe-001"  = ["scem-d-vnt-ase-001", "10.130.18.176/28"]
        "scem-q-sub-ase-app-001" = ["scem-d-vnt-ase-001", "10.130.18.192/28"]
        "scem-q-sub-ase-db-001"  = ["scem-d-vnt-ase-001", "10.130.18.208/28"]
        "scem-q-sub-ase-web-001" = ["scem-d-vnt-ase-001", "10.130.18.224/28"]
        "scem-q-sub-ase-pe-001"  = ["scem-d-vnt-ase-001", "10.130.18.240/28"]
      }
      nsg = {
        "scem-d-nsg-ase-app-001" = "scem-d-rgp-ase-001"
        "scem-d-nsg-ase-web-001" = "scem-d-rgp-ase-001"
        "scem-d-nsg-ase-db-001"  = "scem-d-rgp-ase-001"

        "scem-f-nsg-ase-app-001" = "scem-f-rgp-ase-001"
        "scem-f-nsg-ase-web-001" = "scem-f-rgp-ase-001"
        "scem-f-nsg-ase-db-001"  = "scem-f-rgp-ase-001"

        "scem-q-nsg-ase-app-001" = "scem-q-rgp-ase-001"
        "scem-q-nsg-ase-web-001" = "scem-q-rgp-ase-001"
        "scem-q-nsg-ase-db-001"  = "scem-q-rgp-ase-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-ase-app-001" = "scem-d-sub-ase-app-001"
        "scem-d-nsg-ase-db-001"  = "scem-d-sub-ase-db-001"
        "scem-d-nsg-ase-web-001" = "scem-d-sub-ase-web-001"

        "scem-f-nsg-ase-app-001" = "scem-f-sub-ase-app-001"
        "scem-f-nsg-ase-db-001"  = "scem-f-sub-ase-db-001"
        "scem-f-nsg-ase-web-001" = "scem-f-sub-ase-web-001"

        "scem-q-nsg-ase-app-001" = "scem-q-sub-ase-app-001"
        "scem-q-nsg-ase-db-001"  = "scem-q-sub-ase-db-001"
        "scem-q-nsg-ase-web-001" = "scem-q-sub-ase-web-001"
      }
      route_table = {

        /*"scem-d-rot-ase-app-001" = "scem-d-rgp-ase-001"
          "scem-d-rot-ase-db-001"  = "scem-d-rgp-ase-001"
          "scem-d-rot-ase-web-001" = "scem-d-rgp-ase-001"
          "scem-d-rot-ase-pe-001"  = "scem-d-rgp-ase-001"
          "scem-f-rot-ase-app-001" = "scem-f-rgp-ase-001"
          "scem-f-rot-ase-db-001"  = "scem-f-rgp-ase-001"
          "scem-f-rot-ase-web-001" = "scem-f-rgp-ase-001"
          "scem-f-rot-ase-pe-001"  = "scem-f-rgp-ase-001"
          "scem-q-rot-ase-app-001" = "scem-q-rgp-ase-001"*/
        "scem-q-rot-ase-db-001" = "scem-q-rgp-ase-001"
        /*"scem-q-rot-ase-web-001" = "scem-q-rgp-ase-001"
          "scem-q-rot-ase-pe-001"  = "scem-q-rgp-ase-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotaseapp", "scem-d-rot-ase-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotasedb", "scem-d-rot-ase-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotaseweb", "scem-d-rot-ase-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotaseapp", "scem-f-rot-ase-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotasedb", "scem-f-rot-ase-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotaseweb", "scem-f-rot-ase-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotaseapp", "scem-q-rot-ase-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
        2010 = ["scem-q-udr-fw-rotasedb", "scem-q-rot-ase-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
        /*2210 = ["scem-q-udr-fw-rotaseweb", "scem-q-rot-ase-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotasepe", "scem-d-rot-ase-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotasepe", "scem-f-rot-ase-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotasepe", "scem-q-rot-ase-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-ase-app-001" = "scem-d-sub-ase-app-001"
          "scem-d-rot-ase-db-001"  = "scem-d-sub-ase-db-001"
          "scem-d-rot-ase-web-001" = "scem-d-sub-ase-web-001"
          "scem-d-rot-ase-pe-001"  = "scem-d-sub-ase-pe-001"
          "scem-f-rot-ase-app-001" = "scem-f-sub-ase-app-001"
          "scem-f-rot-ase-db-001"  = "scem-f-sub-ase-db-001"
          "scem-f-rot-ase-web-001" = "scem-f-sub-ase-web-001"
          "scem-f-rot-ase-pe-001"  = "scem-f-sub-ase-pe-001"
          "scem-q-rot-ase-app-001" = "scem-q-sub-ase-app-001"*/
        "scem-q-rot-ase-db-001" = "scem-q-sub-ase-db-001"
        /*"scem-q-rot-ase-web-001" = "scem-q-sub-ase-web-001"
          "scem-q-rot-ase-pe-001"  = "scem-q-sub-ase-pe-001"*/
      }

    }
    emp = {
      rg = {
        "scem-d-rgp-emp-001" = "West US 3"
        "scem-f-rgp-emp-001" = "West US 3"
        "scem-q-rgp-emp-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-emp-001"]

      dpr_virtual_network_link = ["scem-d-vnt-emp-001"]

      virtual_network = {
        "scem-d-vnt-emp-001" = {
          address_space       = ["10.130.20.64/26", "10.130.20.128/25"]
          resource_group_name = "scem-d-rgp-emp-001"
        }
      }
      subnet = {
        "scem-d-sub-emp-app-001" = ["scem-d-vnt-emp-001", "10.130.20.64/28"]
        "scem-d-sub-emp-db-001"  = ["scem-d-vnt-emp-001", "10.130.20.80/28"]
        "scem-d-sub-emp-web-001" = ["scem-d-vnt-emp-001", "10.130.20.96/28"]
        "scem-d-sub-emp-pe-001"  = ["scem-d-vnt-emp-001", "10.130.20.112/28"]
        "scem-f-sub-emp-app-001" = ["scem-d-vnt-emp-001", "10.130.20.128/28"]
        "scem-f-sub-emp-db-001"  = ["scem-d-vnt-emp-001", "10.130.20.144/28"]
        "scem-f-sub-emp-web-001" = ["scem-d-vnt-emp-001", "10.130.20.160/28"]
        "scem-f-sub-emp-pe-001"  = ["scem-d-vnt-emp-001", "10.130.20.176/28"]
        "scem-q-sub-emp-app-001" = ["scem-d-vnt-emp-001", "10.130.20.192/28"]
        "scem-q-sub-emp-db-001"  = ["scem-d-vnt-emp-001", "10.130.20.208/28"]
        "scem-q-sub-emp-web-001" = ["scem-d-vnt-emp-001", "10.130.20.224/28"]
        "scem-q-sub-emp-pe-001"  = ["scem-d-vnt-emp-001", "10.130.20.240/28"]
      }
      nsg = {
        "scem-d-nsg-emp-app-001" = "scem-d-rgp-emp-001"
        "scem-d-nsg-emp-web-001" = "scem-d-rgp-emp-001"
        "scem-d-nsg-emp-db-001"  = "scem-d-rgp-emp-001"

        "scem-f-nsg-emp-app-001" = "scem-f-rgp-emp-001"
        "scem-f-nsg-emp-web-001" = "scem-f-rgp-emp-001"
        "scem-f-nsg-emp-db-001"  = "scem-f-rgp-emp-001"

        "scem-q-nsg-emp-app-001" = "scem-q-rgp-emp-001"
        "scem-q-nsg-emp-web-001" = "scem-q-rgp-emp-001"
        "scem-q-nsg-emp-db-001"  = "scem-q-rgp-emp-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-emp-app-001" = "scem-d-sub-emp-app-001"
        "scem-d-nsg-emp-db-001"  = "scem-d-sub-emp-db-001"
        "scem-d-nsg-emp-web-001" = "scem-d-sub-emp-web-001"

        "scem-f-nsg-emp-app-001" = "scem-f-sub-emp-app-001"
        "scem-f-nsg-emp-db-001"  = "scem-f-sub-emp-db-001"
        "scem-f-nsg-emp-web-001" = "scem-f-sub-emp-web-001"

        "scem-q-nsg-emp-app-001" = "scem-q-sub-emp-app-001"
        "scem-q-nsg-emp-db-001"  = "scem-q-sub-emp-db-001"
        "scem-q-nsg-emp-web-001" = "scem-q-sub-emp-web-001"
      }
      route_table = {

        /*"scem-d-rot-emp-app-001" = "scem-d-rgp-emp-001"
          "scem-d-rot-emp-db-001"  = "scem-d-rgp-emp-001"
          "scem-d-rot-emp-web-001" = "scem-d-rgp-emp-001"
          "scem-d-rot-emp-pe-001"  = "scem-d-rgp-emp-001"
          "scem-f-rot-emp-app-001" = "scem-f-rgp-emp-001"
          "scem-f-rot-emp-db-001"  = "scem-f-rgp-emp-001"
          "scem-f-rot-emp-web-001" = "scem-f-rgp-emp-001"
          "scem-f-rot-emp-pe-001"  = "scem-f-rgp-emp-001"
          "scem-q-rot-emp-app-001" = "scem-q-rgp-emp-001"
          "scem-q-rot-emp-db-001"  = "scem-q-rgp-emp-001"
          "scem-q-rot-emp-web-001" = "scem-q-rgp-emp-001"
          "scem-q-rot-emp-pe-001"  = "scem-q-rgp-emp-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotempapp", "scem-d-rot-emp-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotempdb", "scem-d-rot-emp-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotempweb", "scem-d-rot-emp-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotempapp", "scem-f-rot-emp-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotempdb", "scem-f-rot-emp-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotempweb", "scem-f-rot-emp-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotempapp", "scem-q-rot-emp-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotempdb", "scem-q-rot-emp-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotempweb", "scem-q-rot-emp-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          #2610 = ["scem-d-udr-fw-rotemppe", "scem-d-rot-emp-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotemppe", "scem-f-rot-emp-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotemppe", "scem-q-rot-emp-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-emp-app-001" = "scem-d-sub-emp-app-001"
          "scem-d-rot-emp-db-001"  = "scem-d-sub-emp-db-001"
          "scem-d-rot-emp-web-001" = "scem-d-sub-emp-web-001"
          "scem-d-rot-emp-pe-001"  = "scem-d-sub-emp-pe-001"
          "scem-f-rot-emp-app-001" = "scem-f-sub-emp-app-001"
          "scem-f-rot-emp-db-001"  = "scem-f-sub-emp-db-001"
          "scem-f-rot-emp-web-001" = "scem-f-sub-emp-web-001"
          "scem-f-rot-emp-pe-001"  = "scem-f-sub-emp-pe-001"
          "scem-q-rot-emp-app-001" = "scem-q-sub-emp-app-001"
          "scem-q-rot-emp-db-001"  = "scem-q-sub-emp-db-001"
          "scem-q-rot-emp-web-001" = "scem-q-sub-emp-web-001"
          "scem-q-rot-emp-pe-001"  = "scem-q-sub-emp-pe-001"*/
      }

    }
    nar = {
      rg = {
        "scem-d-rgp-nar-001" = "West US 3"
        "scem-f-rgp-nar-001" = "West US 3"
        "scem-q-rgp-nar-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-nar-001"]

      dpr_virtual_network_link = ["scem-d-vnt-nar-001"]

      virtual_network = {
        "scem-d-vnt-nar-001" = {
          address_space       = ["10.130.21.64/26", "10.130.21.128/25"]
          resource_group_name = "scem-d-rgp-nar-001"
        }
      }
      subnet = {
        "scem-d-sub-nar-app-001" = ["scem-d-vnt-nar-001", "10.130.21.64/28"]
        "scem-d-sub-nar-db-001"  = ["scem-d-vnt-nar-001", "10.130.21.80/28"]
        "scem-d-sub-nar-web-001" = ["scem-d-vnt-nar-001", "10.130.21.96/28"]
        "scem-d-sub-nar-pe-001"  = ["scem-d-vnt-nar-001", "10.130.21.112/28"]
        "scem-f-sub-nar-app-001" = ["scem-d-vnt-nar-001", "10.130.21.128/28"]
        "scem-f-sub-nar-db-001"  = ["scem-d-vnt-nar-001", "10.130.21.144/28"]
        "scem-f-sub-nar-web-001" = ["scem-d-vnt-nar-001", "10.130.21.160/28"]
        "scem-f-sub-nar-pe-001"  = ["scem-d-vnt-nar-001", "10.130.21.176/28"]
        "scem-q-sub-nar-app-001" = ["scem-d-vnt-nar-001", "10.130.21.192/28"]
        "scem-q-sub-nar-db-001"  = ["scem-d-vnt-nar-001", "10.130.21.208/28"]
        "scem-q-sub-nar-web-001" = ["scem-d-vnt-nar-001", "10.130.21.224/28"]
        "scem-q-sub-nar-pe-001"  = ["scem-d-vnt-nar-001", "10.130.21.240/28"]
      }
      nsg = {
        "scem-d-nsg-nar-app-001" = "scem-d-rgp-nar-001"
        "scem-d-nsg-nar-web-001" = "scem-d-rgp-nar-001"
        "scem-d-nsg-nar-db-001"  = "scem-d-rgp-nar-001"

        "scem-f-nsg-nar-app-001" = "scem-f-rgp-nar-001"
        "scem-f-nsg-nar-web-001" = "scem-f-rgp-nar-001"
        "scem-f-nsg-nar-db-001"  = "scem-f-rgp-nar-001"

        "scem-q-nsg-nar-app-001" = "scem-q-rgp-nar-001"
        "scem-q-nsg-nar-web-001" = "scem-q-rgp-nar-001"
        "scem-q-nsg-nar-db-001"  = "scem-q-rgp-nar-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-nar-app-001" = "scem-d-sub-nar-app-001"
        "scem-d-nsg-nar-db-001"  = "scem-d-sub-nar-db-001"
        "scem-d-nsg-nar-web-001" = "scem-d-sub-nar-web-001"

        "scem-f-nsg-nar-app-001" = "scem-f-sub-nar-app-001"
        "scem-f-nsg-nar-db-001"  = "scem-f-sub-nar-db-001"
        "scem-f-nsg-nar-web-001" = "scem-f-sub-nar-web-001"

        "scem-q-nsg-nar-app-001" = "scem-q-sub-nar-app-001"
        "scem-q-nsg-nar-db-001"  = "scem-q-sub-nar-db-001"
        "scem-q-nsg-nar-web-001" = "scem-q-sub-nar-web-001"
      }
      route_table = {

        /*"scem-d-rot-nar-app-001" = "scem-d-rgp-nar-001"
          "scem-d-rot-nar-db-001"  = "scem-d-rgp-nar-001"
          "scem-d-rot-nar-web-001" = "scem-d-rgp-nar-001"
          "scem-d-rot-nar-pe-001"  = "scem-d-rgp-nar-001"
          "scem-f-rot-nar-app-001" = "scem-f-rgp-nar-001"
          "scem-f-rot-nar-db-001"  = "scem-f-rgp-nar-001"
          "scem-f-rot-nar-web-001" = "scem-f-rgp-nar-001"
          "scem-f-rot-nar-pe-001"  = "scem-f-rgp-nar-001"
          "scem-q-rot-nar-app-001" = "scem-q-rgp-nar-001"
          "scem-q-rot-nar-db-001"  = "scem-q-rgp-nar-001"
          "scem-q-rot-nar-web-001" = "scem-q-rgp-nar-001"
          "scem-q-rot-nar-pe-001"  = "scem-q-rgp-nar-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotnarapp", "scem-d-rot-nar-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotnardb", "scem-d-rot-nar-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotnarweb", "scem-d-rot-nar-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotnarapp", "scem-f-rot-nar-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotnardb", "scem-f-rot-nar-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotnarweb", "scem-f-rot-nar-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotnarapp", "scem-q-rot-nar-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotnardb", "scem-q-rot-nar-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotnarweb", "scem-q-rot-nar-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotnarpe", "scem-d-rot-nar-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotnarpe", "scem-f-rot-nar-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          #3010 = ["scem-q-udr-fw-rotnarpe", "scem-q-rot-nar-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-nar-app-001" = "scem-d-sub-nar-app-001"
          "scem-d-rot-nar-db-001"  = "scem-d-sub-nar-db-001"
          "scem-d-rot-nar-web-001" = "scem-d-sub-nar-web-001"
          "scem-d-rot-nar-pe-001"  = "scem-d-sub-nar-pe-001"
          "scem-f-rot-nar-app-001" = "scem-f-sub-nar-app-001"
          "scem-f-rot-nar-db-001"  = "scem-f-sub-nar-db-001"
          "scem-f-rot-nar-web-001" = "scem-f-sub-nar-web-001"
          "scem-f-rot-nar-pe-001"  = "scem-f-sub-nar-pe-001"
          "scem-q-rot-nar-app-001" = "scem-q-sub-nar-app-001"
          "scem-q-rot-nar-db-001"  = "scem-q-sub-nar-db-001"
          "scem-q-rot-nar-web-001" = "scem-q-sub-nar-web-001"
          "scem-q-rot-nar-pe-001"  = "scem-q-sub-nar-pe-001"*/
      }

    }
    roc = {
      rg = {
        "scem-d-rgp-roc-001" = "West US 3"
        "scem-f-rgp-roc-001" = "West US 3"
        "scem-q-rgp-roc-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-roc-001"]

      dpr_virtual_network_link = ["scem-d-vnt-roc-001"]

      virtual_network = {
        "scem-d-vnt-roc-001" = {
          address_space       = ["10.130.34.64/26", "10.130.34.128/25"]
          resource_group_name = "scem-d-rgp-roc-001"
        }
      }
      subnet = {
        "scem-d-sub-roc-app-001" = ["scem-d-vnt-roc-001", "10.130.34.64/28"]
        "scem-d-sub-roc-db-001"  = ["scem-d-vnt-roc-001", "10.130.34.80/28"]
        "scem-d-sub-roc-web-001" = ["scem-d-vnt-roc-001", "10.130.34.96/28"]
        "scem-d-sub-roc-pe-001"  = ["scem-d-vnt-roc-001", "10.130.34.112/28"]
        "scem-f-sub-roc-app-001" = ["scem-d-vnt-roc-001", "10.130.34.128/28"]
        "scem-f-sub-roc-db-001"  = ["scem-d-vnt-roc-001", "10.130.34.144/28"]
        "scem-f-sub-roc-web-001" = ["scem-d-vnt-roc-001", "10.130.34.160/28"]
        "scem-f-sub-roc-pe-001"  = ["scem-d-vnt-roc-001", "10.130.34.176/28"]
        "scem-q-sub-roc-app-001" = ["scem-d-vnt-roc-001", "10.130.34.192/28"]
        "scem-q-sub-roc-db-001"  = ["scem-d-vnt-roc-001", "10.130.34.208/28"]
        "scem-q-sub-roc-web-001" = ["scem-d-vnt-roc-001", "10.130.34.224/28"]
        "scem-q-sub-roc-pe-001"  = ["scem-d-vnt-roc-001", "10.130.34.240/28"]
      }
      nsg = {
        "scem-d-nsg-roc-app-001" = "scem-d-rgp-roc-001"
        "scem-d-nsg-roc-web-001" = "scem-d-rgp-roc-001"
        "scem-d-nsg-roc-db-001"  = "scem-d-rgp-roc-001"

        "scem-f-nsg-roc-app-001" = "scem-f-rgp-roc-001"
        "scem-f-nsg-roc-web-001" = "scem-f-rgp-roc-001"
        "scem-f-nsg-roc-db-001"  = "scem-f-rgp-roc-001"

        "scem-q-nsg-roc-app-001" = "scem-q-rgp-roc-001"
        "scem-q-nsg-roc-web-001" = "scem-q-rgp-roc-001"
        "scem-q-nsg-roc-db-001"  = "scem-q-rgp-roc-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-roc-app-001" = "scem-d-sub-roc-app-001"
        "scem-d-nsg-roc-db-001"  = "scem-d-sub-roc-db-001"
        "scem-d-nsg-roc-web-001" = "scem-d-sub-roc-web-001"

        "scem-f-nsg-roc-app-001" = "scem-f-sub-roc-app-001"
        "scem-f-nsg-roc-db-001"  = "scem-f-sub-roc-db-001"
        "scem-f-nsg-roc-web-001" = "scem-f-sub-roc-web-001"

        "scem-q-nsg-roc-app-001" = "scem-q-sub-roc-app-001"
        "scem-q-nsg-roc-db-001"  = "scem-q-sub-roc-db-001"
        "scem-q-nsg-roc-web-001" = "scem-q-sub-roc-web-001"
      }
      route_table = {

        /*"scem-d-rot-roc-app-001" = "scem-d-rgp-roc-001"
          "scem-d-rot-roc-db-001"  = "scem-d-rgp-roc-001"
          "scem-d-rot-roc-web-001" = "scem-d-rgp-roc-001"
          "scem-d-rot-roc-pe-001"  = "scem-d-rgp-roc-001"
          "scem-f-rot-roc-app-001" = "scem-f-rgp-roc-001"
          "scem-f-rot-roc-db-001"  = "scem-f-rgp-roc-001"
          "scem-f-rot-roc-web-001" = "scem-f-rgp-roc-001"
          "scem-f-rot-roc-pe-001"  = "scem-f-rgp-roc-001"
          "scem-q-rot-roc-app-001" = "scem-q-rgp-roc-001"
          "scem-q-rot-roc-db-001"  = "scem-q-rgp-roc-001"
          "scem-q-rot-roc-web-001" = "scem-q-rgp-roc-001"
          "scem-q-rot-roc-pe-001"  = "scem-q-rgp-roc-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotrocapp", "scem-d-rot-roc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotrocdb", "scem-d-rot-roc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotrocweb", "scem-d-rot-roc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotrocapp", "scem-f-rot-roc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotrocdb", "scem-f-rot-roc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotrocweb", "scem-f-rot-roc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotrocapp", "scem-q-rot-roc-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotrocdb", "scem-q-rot-roc-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotrocweb", "scem-q-rot-roc-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotrocpe", "scem-d-rot-roc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotrocpe", "scem-f-rot-roc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotrocpe", "scem-q-rot-roc-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-roc-app-001" = "scem-d-sub-roc-app-001"
          "scem-d-rot-roc-db-001"  = "scem-d-sub-roc-db-001"
          "scem-d-rot-roc-web-001" = "scem-d-sub-roc-web-001"
          "scem-d-rot-roc-pe-001"  = "scem-d-sub-roc-pe-001"
          "scem-f-rot-roc-app-001" = "scem-f-sub-roc-app-001"
          "scem-f-rot-roc-db-001"  = "scem-f-sub-roc-db-001"
          "scem-f-rot-roc-web-001" = "scem-f-sub-roc-web-001"
          "scem-f-rot-roc-pe-001"  = "scem-f-sub-roc-pe-001"
          "scem-q-rot-roc-app-001" = "scem-q-sub-roc-app-001"
          "scem-q-rot-roc-db-001"  = "scem-q-sub-roc-db-001"
          "scem-q-rot-roc-web-001" = "scem-q-sub-roc-web-001"
          "scem-q-rot-roc-pe-001"  = "scem-q-sub-roc-pe-001"*/
      }

    }
    sca = {
      rg = {
        "scem-d-rgp-sca-001" = "West US 3"
        "scem-f-rgp-sca-001" = "West US 3"
        "scem-q-rgp-sca-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-sca-001"]

      dpr_virtual_network_link = ["scem-d-vnt-sca-001"]

      virtual_network = {
        "scem-d-vnt-sca-001" = {
          address_space       = ["10.130.24.64/26", "10.130.24.128/25"]
          resource_group_name = "scem-d-rgp-sca-001"
        }
      }
      subnet = {
        "scem-d-sub-sca-app-001" = ["scem-d-vnt-sca-001", "10.130.24.64/28"]
        "scem-d-sub-sca-db-001"  = ["scem-d-vnt-sca-001", "10.130.24.80/28"]
        "scem-d-sub-sca-web-001" = ["scem-d-vnt-sca-001", "10.130.24.96/28"]
        "scem-d-sub-sca-pe-001"  = ["scem-d-vnt-sca-001", "10.130.24.112/28"]
        "scem-f-sub-sca-app-001" = ["scem-d-vnt-sca-001", "10.130.24.128/28"]
        "scem-f-sub-sca-db-001"  = ["scem-d-vnt-sca-001", "10.130.24.144/28"]
        "scem-f-sub-sca-web-001" = ["scem-d-vnt-sca-001", "10.130.24.160/28"]
        "scem-f-sub-sca-pe-001"  = ["scem-d-vnt-sca-001", "10.130.24.176/28"]
        "scem-q-sub-sca-app-001" = ["scem-d-vnt-sca-001", "10.130.24.192/28"]
        "scem-q-sub-sca-db-001"  = ["scem-d-vnt-sca-001", "10.130.24.208/28"]
        "scem-q-sub-sca-web-001" = ["scem-d-vnt-sca-001", "10.130.24.224/28"]
        "scem-q-sub-sca-pe-001"  = ["scem-d-vnt-sca-001", "10.130.24.240/28"]
      }
      nsg = {
        "scem-d-nsg-sca-app-001" = "scem-d-rgp-sca-001"
        "scem-d-nsg-sca-web-001" = "scem-d-rgp-sca-001"
        "scem-d-nsg-sca-db-001"  = "scem-d-rgp-sca-001"

        "scem-f-nsg-sca-app-001" = "scem-f-rgp-sca-001"
        "scem-f-nsg-sca-web-001" = "scem-f-rgp-sca-001"
        "scem-f-nsg-sca-db-001"  = "scem-f-rgp-sca-001"

        "scem-q-nsg-sca-app-001" = "scem-q-rgp-sca-001"
        "scem-q-nsg-sca-web-001" = "scem-q-rgp-sca-001"
        "scem-q-nsg-sca-db-001"  = "scem-q-rgp-sca-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-sca-app-001" = "scem-d-sub-sca-app-001"
        "scem-d-nsg-sca-db-001"  = "scem-d-sub-sca-db-001"
        "scem-d-nsg-sca-web-001" = "scem-d-sub-sca-web-001"

        "scem-f-nsg-sca-app-001" = "scem-f-sub-sca-app-001"
        "scem-f-nsg-sca-db-001"  = "scem-f-sub-sca-db-001"
        "scem-f-nsg-sca-web-001" = "scem-f-sub-sca-web-001"

        "scem-q-nsg-sca-app-001" = "scem-q-sub-sca-app-001"
        "scem-q-nsg-sca-db-001"  = "scem-q-sub-sca-db-001"
        "scem-q-nsg-sca-web-001" = "scem-q-sub-sca-web-001"
      }
      route_table = {

        /*"scem-d-rot-sca-app-001" = "scem-d-rgp-sca-001"
          "scem-d-rot-sca-db-001"  = "scem-d-rgp-sca-001"
          "scem-d-rot-sca-web-001" = "scem-d-rgp-sca-001"
          "scem-d-rot-sca-pe-001"  = "scem-d-rgp-sca-001"
          "scem-f-rot-sca-app-001" = "scem-f-rgp-sca-001"
          "scem-f-rot-sca-db-001"  = "scem-f-rgp-sca-001"
          "scem-f-rot-sca-web-001" = "scem-f-rgp-sca-001"
          "scem-f-rot-sca-pe-001"  = "scem-f-rgp-sca-001"
          "scem-q-rot-sca-app-001" = "scem-q-rgp-sca-001"
          "scem-q-rot-sca-db-001"  = "scem-q-rgp-sca-001"
          "scem-q-rot-sca-web-001" = "scem-q-rgp-sca-001"
          "scem-q-rot-sca-pe-001"  = "scem-q-rgp-sca-001"*/
      }
      udr = {
        /* 610  = ["scem-d-udr-fw-rotscaapp", "scem-d-rot-sca-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotscadb", "scem-d-rot-sca-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotscaweb", "scem-d-rot-sca-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotscaapp", "scem-f-rot-sca-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotscadb", "scem-f-rot-sca-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotscaweb", "scem-f-rot-sca-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotscaapp", "scem-q-rot-sca-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotscadb", "scem-q-rot-sca-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotscaweb", "scem-q-rot-sca-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotscape", "scem-d-rot-sca-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotscape", "scem-f-rot-sca-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotscape", "scem-q-rot-sca-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-sca-app-001" = "scem-d-sub-sca-app-001"
          "scem-d-rot-sca-db-001"  = "scem-d-sub-sca-db-001"
          "scem-d-rot-sca-web-001" = "scem-d-sub-sca-web-001"
          "scem-d-rot-sca-pe-001"  = "scem-d-sub-sca-pe-001"
          "scem-f-rot-sca-app-001" = "scem-f-sub-sca-app-001"
          "scem-f-rot-sca-db-001"  = "scem-f-sub-sca-db-001"
          "scem-f-rot-sca-web-001" = "scem-f-sub-sca-web-001"
          "scem-f-rot-sca-pe-001"  = "scem-f-sub-sca-pe-001"
          "scem-q-rot-sca-app-001" = "scem-q-sub-sca-app-001"
          "scem-q-rot-sca-db-001"  = "scem-q-sub-sca-db-001"
          "scem-q-rot-sca-web-001" = "scem-q-sub-sca-web-001"
          "scem-q-rot-sca-pe-001"  = "scem-q-sub-sca-pe-001"*/
      }

    }
    wsm = {
      rg = {
        "scem-d-rgp-wsm-001" = "West US 3"
        "scem-f-rgp-wsm-001" = "West US 3"
        "scem-q-rgp-wsm-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-wsm-001"]

      dpr_virtual_network_link = ["scem-d-vnt-wsm-001"]

      virtual_network = {
        "scem-d-vnt-wsm-001" = {
          address_space       = ["10.130.25.64/26", "10.130.25.128/25"]
          resource_group_name = "scem-d-rgp-wsm-001"
        }
      }
      subnet = {
        "scem-d-sub-wsm-app-001"   = ["scem-d-vnt-wsm-001", "10.130.25.64/28"]
        "scem-d-sub-wsm-db-001"    = ["scem-d-vnt-wsm-001", "10.130.25.80/28"]
        "scem-d-sub-wsm-web-001"   = ["scem-d-vnt-wsm-001", "10.130.25.96/28"]
        "scem-d-sub-wsm-pe-001"    = ["scem-d-vnt-wsm-001", "10.130.25.112/28"]
        "scem-f-sub-wsm-app-001"   = ["scem-d-vnt-wsm-001", "10.130.25.128/28"]
        "scem-f-sub-wsm-db-001"    = ["scem-d-vnt-wsm-001", "10.130.25.144/28"]
        "scem-f-sub-wsm-web-001"   = ["scem-d-vnt-wsm-001", "10.130.25.160/28"]
        "scem-f-sub-wsm-pe-001"    = ["scem-d-vnt-wsm-001", "10.130.25.176/28"]
        "scem-q-sub-wsm-app-001"   = ["scem-d-vnt-wsm-001", "10.130.25.192/28"]
        "scem-q-sub-wsm-pe-001"    = ["scem-d-vnt-wsm-001", "10.130.25.208/28"]
        "scem-q-sub-wsm-sqlmi-001" = ["scem-d-vnt-wsm-001", "10.130.25.224/27"]
        # "scem-q-sub-wsm-pe-001"  = ["scem-d-vnt-wsm-001", "10.130.25.240/28"]
      }
      nsg = {
        "scem-d-nsg-wsm-app-001" = "scem-d-rgp-wsm-001"
        "scem-d-nsg-wsm-web-001" = "scem-d-rgp-wsm-001"
        "scem-d-nsg-wsm-db-001"  = "scem-d-rgp-wsm-001"

        "scem-f-nsg-wsm-app-001" = "scem-f-rgp-wsm-001"
        "scem-f-nsg-wsm-web-001" = "scem-f-rgp-wsm-001"
        "scem-f-nsg-wsm-db-001"  = "scem-f-rgp-wsm-001"

        "scem-q-nsg-wsm-app-001" = "scem-q-rgp-wsm-001"
        #"scem-q-nsg-wsm-web-001" = "scem-q-rgp-wsm-001"
        "scem-q-nsg-wsm-db-001" = "scem-q-rgp-wsm-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-wsm-app-001" = "scem-d-sub-wsm-app-001"
        "scem-d-nsg-wsm-db-001"  = "scem-d-sub-wsm-db-001"
        "scem-d-nsg-wsm-web-001" = "scem-d-sub-wsm-web-001"

        "scem-f-nsg-wsm-app-001" = "scem-f-sub-wsm-app-001"
        "scem-f-nsg-wsm-db-001"  = "scem-f-sub-wsm-db-001"
        "scem-f-nsg-wsm-web-001" = "scem-f-sub-wsm-web-001"

        "scem-q-nsg-wsm-app-001" = "scem-q-sub-wsm-app-001"
        "scem-q-nsg-wsm-db-001"  = "scem-q-sub-wsm-sqlmi-001"
        #"scem-q-nsg-wsm-web-001" = "scem-q-sub-wsm-web-001"
      }
      route_table = {

        /*"scem-d-rot-wsm-app-001" = "scem-d-rgp-wsm-001"
          "scem-d-rot-wsm-db-001"  = "scem-d-rgp-wsm-001"
          "scem-d-rot-wsm-web-001" = "scem-d-rgp-wsm-001"
          "scem-d-rot-wsm-pe-001"  = "scem-d-rgp-wsm-001"
          "scem-f-rot-wsm-app-001" = "scem-f-rgp-wsm-001"
          "scem-f-rot-wsm-db-001"  = "scem-f-rgp-wsm-001"
          "scem-f-rot-wsm-web-001" = "scem-f-rgp-wsm-001"
          "scem-f-rot-wsm-pe-001"  = "scem-f-rgp-wsm-001"
          "scem-q-rot-wsm-app-001" = "scem-q-rgp-wsm-001"*/
        "scem-q-rot-wsm-db-001" = "scem-q-rgp-wsm-001"
        #"scem-q-rot-wsm-web-001" = "scem-q-rgp-wsm-001"
        #"scem-q-rot-wsm-pe-001"  = "scem-q-rgp-wsm-001"
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotwsmapp", "scem-d-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotwsmdb", "scem-d-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotwsmweb", "scem-d-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotwsmapp", "scem-f-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotwsmdb", "scem-f-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotwsmweb", "scem-f-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotwsmapp", "scem-q-rot-wsm-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotwsmdb", "scem-q-rot-wsm-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
         # 2210 = ["scem-q-udr-fw-rotwsmweb", "scem-q-rot-wsm-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          #2610 = ["scem-d-udr-fw-rotwsmpe", "scem-d-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotwsmpe", "scem-f-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotwsmpe", "scem-q-rot-wsm-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-wsm-app-001" = "scem-d-sub-wsm-app-001"
          "scem-d-rot-wsm-db-001"  = "scem-d-sub-wsm-db-001"
          "scem-d-rot-wsm-web-001" = "scem-d-sub-wsm-web-001"
          "scem-d-rot-wsm-pe-001"  = "scem-d-sub-wsm-pe-001"
          "scem-f-rot-wsm-app-001" = "scem-f-sub-wsm-app-001"
          "scem-f-rot-wsm-db-001"  = "scem-f-sub-wsm-db-001"
          "scem-f-rot-wsm-web-001" = "scem-f-sub-wsm-web-001"
          "scem-f-rot-wsm-pe-001"  = "scem-f-sub-wsm-pe-001"
          "scem-q-rot-wsm-app-001" = "scem-q-sub-wsm-app-001"*/
        "scem-q-rot-wsm-db-001" = "scem-q-sub-wsm-sqlmi-001"
        # "scem-q-rot-wsm-web-001" = "scem-q-sub-wsm-web-001"
        # "scem-q-rot-wsm-pe-001"  = "scem-q-sub-wsm-pe-001"
      }
    }
    wtr = {
      rg = {
        "scem-d-rgp-wtr-001" = "West US 3"
        "scem-f-rgp-wtr-001" = "West US 3"
        "scem-q-rgp-wtr-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-wtr-001"]

      dpr_virtual_network_link = ["scem-d-vnt-wtr-001"]

      virtual_network = {
        "scem-d-vnt-wtr-001" = {
          address_space       = ["10.130.26.64/26", "10.130.26.128/25"]
          resource_group_name = "scem-d-rgp-wtr-001"
        }
      }
      subnet = {
        "scem-d-sub-wtr-app-001" = ["scem-d-vnt-wtr-001", "10.130.26.64/28"]
        "scem-d-sub-wtr-db-001"  = ["scem-d-vnt-wtr-001", "10.130.26.80/28"]
        "scem-d-sub-wtr-web-001" = ["scem-d-vnt-wtr-001", "10.130.26.96/28"]
        "scem-d-sub-wtr-pe-001"  = ["scem-d-vnt-wtr-001", "10.130.26.112/28"]
        "scem-f-sub-wtr-app-001" = ["scem-d-vnt-wtr-001", "10.130.26.128/28"]
        "scem-f-sub-wtr-db-001"  = ["scem-d-vnt-wtr-001", "10.130.26.144/28"]
        "scem-f-sub-wtr-web-001" = ["scem-d-vnt-wtr-001", "10.130.26.160/28"]
        "scem-f-sub-wtr-pe-001"  = ["scem-d-vnt-wtr-001", "10.130.26.176/28"]
        "scem-q-sub-wtr-app-001" = ["scem-d-vnt-wtr-001", "10.130.26.192/28"]
        "scem-q-sub-wtr-db-001"  = ["scem-d-vnt-wtr-001", "10.130.26.208/28"]
        "scem-q-sub-wtr-web-001" = ["scem-d-vnt-wtr-001", "10.130.26.224/28"]
        "scem-q-sub-wtr-pe-001"  = ["scem-d-vnt-wtr-001", "10.130.26.240/28"]
      }
      nsg = {
        "scem-d-nsg-wtr-app-001" = "scem-d-rgp-wtr-001"
        "scem-d-nsg-wtr-web-001" = "scem-d-rgp-wtr-001"
        "scem-d-nsg-wtr-db-001"  = "scem-d-rgp-wtr-001"

        "scem-f-nsg-wtr-app-001" = "scem-f-rgp-wtr-001"
        "scem-f-nsg-wtr-web-001" = "scem-f-rgp-wtr-001"
        "scem-f-nsg-wtr-db-001"  = "scem-f-rgp-wtr-001"

        "scem-q-nsg-wtr-app-001" = "scem-q-rgp-wtr-001"
        "scem-q-nsg-wtr-web-001" = "scem-q-rgp-wtr-001"
        "scem-q-nsg-wtr-db-001"  = "scem-q-rgp-wtr-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        1 = ["scem-d-nsg-wtr-app-001", "scem-d-sub-wtr-app-001"]
        2 = ["scem-d-nsg-wtr-db-001", "scem-d-sub-wtr-db-001"]
        3 = ["scem-d-nsg-wtr-web-001", "scem-d-sub-wtr-web-001"]

        4 = ["scem-f-nsg-wtr-app-001", "scem-f-sub-wtr-app-001"]
        5 = ["scem-f-nsg-wtr-db-001", "scem-f-sub-wtr-db-001"]
        6 = ["scem-f-nsg-wtr-web-001", "scem-f-sub-wtr-web-001"]

        7 = ["scem-q-nsg-wtr-app-001", "scem-q-sub-wtr-app-001"]
        8 = ["scem-q-nsg-wtr-db-001", "scem-q-sub-wtr-db-001"]
        9 = ["scem-q-nsg-wtr-web-001", "scem-q-sub-wtr-web-001"]
      }
      route_table = {

        /*"scem-d-rot-wtr-app-001" = "scem-d-rgp-wtr-001"
          "scem-d-rot-wtr-db-001"  = "scem-d-rgp-wtr-001"
          "scem-d-rot-wtr-web-001" = "scem-d-rgp-wtr-001"
          "scem-d-rot-wtr-pe-001"  = "scem-d-rgp-wtr-001"
          "scem-f-rot-wtr-app-001" = "scem-f-rgp-wtr-001"
          "scem-f-rot-wtr-db-001"  = "scem-f-rgp-wtr-001"
          "scem-f-rot-wtr-web-001" = "scem-f-rgp-wtr-001"
          "scem-f-rot-wtr-pe-001"  = "scem-f-rgp-wtr-001"
          "scem-q-rot-wtr-app-001" = "scem-q-rgp-wtr-001"
          "scem-q-rot-wtr-db-001"  = "scem-q-rgp-wtr-001"
          "scem-q-rot-wtr-web-001" = "scem-q-rgp-wtr-001"
          "scem-q-rot-wtr-pe-001"  = "scem-q-rgp-wtr-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotwtrapp", "scem-d-rot-wtr-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotwtrdb", "scem-d-rot-wtr-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotwtrweb", "scem-d-rot-wtr-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotwtrapp", "scem-f-rot-wtr-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotwtrdb", "scem-f-rot-wtr-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotwtrweb", "scem-f-rot-wtr-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotwtrapp", "scem-q-rot-wtr-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotwtrdb", "scem-q-rot-wtr-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotwtrweb", "scem-q-rot-wtr-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotwtrpe", "scem-d-rot-wtr-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotwtrpe", "scem-f-rot-wtr-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotwtrpe", "scem-q-rot-wtr-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*1 = ["scem-d-rot-wtr-app-001", "scem-d-sub-wtr-app-001"]
          2 = ["scem-d-rot-wtr-db-001", "scem-d-sub-wtr-db-001"]
          3 = ["scem-d-rot-wtr-web-001", "scem-d-sub-wtr-web-001"]
          4 = ["scem-d-rot-wtr-pe-001", "scem-d-sub-wtr-pe-001"]
          5 = ["scem-f-rot-wtr-app-001", "scem-f-sub-wtr-app-001"]
          6 = ["scem-f-rot-wtr-db-001", "scem-f-sub-wtr-db-001"]
          7 = ["scem-f-rot-wtr-web-001", "scem-f-sub-wtr-web-001"]
          8 = ["scem-f-rot-wtr-pe-001", "scem-f-sub-wtr-pe-001"]
          9 = ["scem-q-rot-wtr-app-001", "scem-q-sub-wtr-app-001"]
         10 = ["scem-q-rot-wtr-db-001", "scem-q-sub-wtr-db-001"]
         11 = ["scem-q-rot-wtr-web-001", "scem-q-sub-wtr-web-001"]
         12 = ["scem-q-rot-wtr-pe-001", "scem-q-sub-wtr-pe-001"]*/
      }

    }

    appservice = {
      rg = {
        "scem-d-rgp-cma_appservice-001" = "West US 3"
        #"scem-d-rgp-emp_appservice-001" = "West US 3"
        #"scem-d-rgp-wtr_appservice-001" = "West US 3"
        "scem-d-rgp-emp-001appservice"   = "West US 3"
        "scem-d-rgp-wtr-001appservice"   = "West US 3"
        "scem-d-rgp-WUS3_appservice-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-WUS3_appservice-001"]

      dpr_virtual_network_link = ["scem-d-vnt-WUS3_appservice-001"]

      virtual_network = {
        /*"scem-d-vnt-cma_appservice-001" = {
            address_space       = ["10.130.22.0/24","10.130.31.0/28"]
            resource_group_name = "scem-d-rgp-cma_appservice-001"
          },
          "scem-d-vnt-WUS3_appservice-001" = {
            address_space       = ["10.130.39.0/24","10.130.31.128/28"]
            resource_group_name = "scem-d-rgp-WUS3_appservice-001"
          }*/
        "scem-d-vnt-WUS3_appservice-001" = {
          address_space       = ["10.130.22.0/24", "10.130.31.0/28"]
          resource_group_name = "scem-d-rgp-WUS3_appservice-001"
        }
      }
      subnet = {
        #"scem-d-sub-cma_appservice-001" = ["scem-d-vnt-cma_appservice-001", "10.130.22.0/24"]
        #"scem-d-sub-cma_appservice_pe-001" = ["scem-d-vnt-cma_appservice-001", "10.130.31.0/28"]
        #"scem-d-sub-WUS3_appservice-001" = ["scem-d-vnt-WUS3_appservice-001", "10.130.39.0/24"]
        #"scem-d-sub-WUS3_appservice_pe-001" = ["scem-d-vnt-WUS3_appservice-001", "10.130.31.128/28"]
        "scem-d-sub-WUS3_appservice-001"    = ["scem-d-vnt-WUS3_appservice-001", "10.130.22.0/24"]
        "scem-d-sub-WUS3_appservice_pe-001" = ["scem-d-vnt-WUS3_appservice-001", "10.130.31.0/28"]
      }
      nsg = {
        #"scem-d-nsg-cma_appservice-001" = "scem-d-rgp-cma_appservice-001"
        "scem-d-nsg-WUS3_appservice-001" = "scem-d-rgp-WUS3_appservice-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        #"scem-d-nsg-cma_appservice-001" = "scem-d-sub-cma_appservice-001"
        "scem-d-nsg-WUS3_appservice-001" = "scem-d-sub-WUS3_appservice-001"
      }
      route_table = {

        /*"scem-d-rot-cma_appservice-001" = "scem-d-rgp-cma_appservice-001"
          "scem-d-rot-cma_appservice_pe-001" = "scem-d-rgp-cma_appservice-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotappservice", "scem-d-rot-cma_appservice-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
            1  = ["scem-d-udr-fw-rotappservice_pe", "scem-d-rot-cma_appservice_pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-cma_appservice-001" = "scem-d-sub-cma_appservice-001"
          "scem-d-rot-cma_appservice_pe-001" = "scem-d-sub-cma_appservice_pe-001"*/
      }

    }
    jks = {
      rg = {
        "scem-d-rgp-jks-001" = "West US 3"
        "scem-f-rgp-jks-001" = "West US 3"
        "scem-q-rgp-jks-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-jks-001"]

      dpr_virtual_network_link = ["scem-d-vnt-jks-001"]

      virtual_network = {
        "scem-d-vnt-jks-001" = {
          address_space       = ["10.130.32.64/26", "10.130.32.128/25"]
          resource_group_name = "scem-d-rgp-jks-001"
        }
      }
      subnet = {
        "scem-d-sub-jks-app-001" = ["scem-d-vnt-jks-001", "10.130.32.64/28"]
        "scem-d-sub-jks-db-001"  = ["scem-d-vnt-jks-001", "10.130.32.80/28"]
        "scem-d-sub-jks-app-002" = ["scem-d-vnt-jks-001", "10.130.32.96/28"]
        "scem-d-sub-jks-pe-001"  = ["scem-d-vnt-jks-001", "10.130.32.112/28"]
        "scem-f-sub-jks-app-001" = ["scem-d-vnt-jks-001", "10.130.32.128/28"]
        "scem-f-sub-jks-db-001"  = ["scem-d-vnt-jks-001", "10.130.32.144/28"]
        "scem-f-sub-jks-web-001" = ["scem-d-vnt-jks-001", "10.130.32.160/28"]
        "scem-f-sub-jks-pe-001"  = ["scem-d-vnt-jks-001", "10.130.32.176/28"]
        "scem-q-sub-jks-app-001" = ["scem-d-vnt-jks-001", "10.130.32.192/28"]
        "scem-q-sub-jks-db-001"  = ["scem-d-vnt-jks-001", "10.130.32.208/28"]
        "scem-q-sub-jks-web-001" = ["scem-d-vnt-jks-001", "10.130.32.224/28"]
        "scem-q-sub-jks-pe-001"  = ["scem-d-vnt-jks-001", "10.130.32.240/28"]
      }
      nsg = {
        "scem-d-nsg-jks-app-001" = "scem-d-rgp-jks-001"
        #"scem-d-nsg-jks-web-001" = "scem-d-rgp-jks-001"
        "scem-d-nsg-jks-db-001" = "scem-d-rgp-jks-001"

        "scem-f-nsg-jks-app-001" = "scem-f-rgp-jks-001"
        "scem-f-nsg-jks-web-001" = "scem-f-rgp-jks-001"
        "scem-f-nsg-jks-db-001"  = "scem-f-rgp-jks-001"

        "scem-q-nsg-jks-app-001" = "scem-q-rgp-jks-001"
        "scem-q-nsg-jks-web-001" = "scem-q-rgp-jks-001"
        "scem-q-nsg-jks-db-001"  = "scem-q-rgp-jks-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-jks-app-001" = "scem-d-sub-jks-app-001"
        "scem-d-nsg-jks-db-001"  = "scem-d-sub-jks-db-001"
        #"scem-d-nsg-jks-web-001" = "scem-d-sub-jks-web-001"

        "scem-f-nsg-jks-app-001" = "scem-f-sub-jks-app-001"
        "scem-f-nsg-jks-db-001"  = "scem-f-sub-jks-db-001"
        "scem-f-nsg-jks-web-001" = "scem-f-sub-jks-web-001"

        "scem-q-nsg-jks-app-001" = "scem-q-sub-jks-app-001"
        "scem-q-nsg-jks-db-001"  = "scem-q-sub-jks-db-001"
        "scem-q-nsg-jks-web-001" = "scem-q-sub-jks-web-001"
      }
      route_table = {

        /*"scem-d-rot-jks-app-001" = "scem-d-rgp-jks-001"
          "scem-d-rot-jks-db-001"  = "scem-d-rgp-jks-001"
          #"scem-d-rot-jks-web-001" = "scem-d-rgp-jks-001"
          #"scem-d-rot-jks-pe-001"  = "scem-d-rgp-jks-001"
          "scem-f-rot-jks-app-001" = "scem-f-rgp-jks-001"
          "scem-f-rot-jks-db-001"  = "scem-f-rgp-jks-001"
          "scem-f-rot-jks-web-001" = "scem-f-rgp-jks-001"
          "scem-f-rot-jks-pe-001"  = "scem-f-rgp-jks-001"
          "scem-q-rot-jks-app-001" = "scem-q-rgp-jks-001"
          "scem-q-rot-jks-db-001"  = "scem-q-rgp-jks-001"
          "scem-q-rot-jks-web-001" = "scem-q-rgp-jks-001"
          "scem-q-rot-jks-pe-001"  = "scem-q-rgp-jks-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotjksapp", "scem-d-rot-jks-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotjksdb", "scem-d-rot-jks-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          #1010 = ["scem-d-udr-fw-rotjksweb", "scem-d-rot-jks-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotjksapp", "scem-f-rot-jks-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotjksdb", "scem-f-rot-jks-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotjksweb", "scem-f-rot-jks-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotjksapp", "scem-q-rot-jks-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotjksdb", "scem-q-rot-jks-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotjksweb", "scem-q-rot-jks-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          #2610 = ["scem-d-udr-fw-rotjkspe", "scem-d-rot-jks-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotjkspe", "scem-f-rot-jks-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotjkspe", "scem-q-rot-jks-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-jks-app-001" = "scem-d-sub-jks-app-001"
          "scem-d-rot-jks-db-001"  = "scem-d-sub-jks-db-001"
          #"scem-d-rot-jks-web-001" = "scem-d-sub-jks-web-001"
          #"scem-d-rot-jks-pe-001"  = "scem-d-sub-jks-pe-001"
          "scem-f-rot-jks-app-001" = "scem-f-sub-jks-app-001"
          "scem-f-rot-jks-db-001"  = "scem-f-sub-jks-db-001"
          "scem-f-rot-jks-web-001" = "scem-f-sub-jks-web-001"
          "scem-f-rot-jks-pe-001"  = "scem-f-sub-jks-pe-001"
          "scem-q-rot-jks-app-001" = "scem-q-sub-jks-app-001"
          "scem-q-rot-jks-db-001"  = "scem-q-sub-jks-db-001"
          "scem-q-rot-jks-web-001" = "scem-q-sub-jks-web-001"
          "scem-q-rot-jks-pe-001"  = "scem-q-sub-jks-pe-001"*/
      }

    }
    psw = {
      rg = {
        "scem-d-rgp-psw-001" = "West US 3"
        "scem-f-rgp-psw-001" = "West US 3"
        "scem-q-rgp-psw-001" = "West US 3"
      }

      hubpeers = ["scem-d-vnt-psw-001"]

      dpr_virtual_network_link = ["scem-d-vnt-psw-001"]

      virtual_network = {
        "scem-d-vnt-psw-001" = {
          address_space       = ["10.130.33.64/26", "10.130.33.128/25"]
          resource_group_name = "scem-d-rgp-psw-001"
        }
      }
      subnet = {
        "scem-d-sub-psw-app-001" = ["scem-d-vnt-psw-001", "10.130.33.64/28"]
        "scem-d-sub-psw-db-001"  = ["scem-d-vnt-psw-001", "10.130.33.80/28"]
        "scem-d-sub-psw-web-001" = ["scem-d-vnt-psw-001", "10.130.33.96/28"]
        "scem-d-sub-psw-pe-001"  = ["scem-d-vnt-psw-001", "10.130.33.112/28"]
        "scem-f-sub-psw-app-001" = ["scem-d-vnt-psw-001", "10.130.33.128/28"]
        "scem-f-sub-psw-db-001"  = ["scem-d-vnt-psw-001", "10.130.33.144/28"]
        "scem-f-sub-psw-web-001" = ["scem-d-vnt-psw-001", "10.130.33.160/28"]
        "scem-f-sub-psw-pe-001"  = ["scem-d-vnt-psw-001", "10.130.33.176/28"]
        "scem-q-sub-psw-app-001" = ["scem-d-vnt-psw-001", "10.130.33.192/28"]
        "scem-q-sub-psw-db-001"  = ["scem-d-vnt-psw-001", "10.130.33.208/28"]
        "scem-q-sub-psw-web-001" = ["scem-d-vnt-psw-001", "10.130.33.224/28"]
        "scem-q-sub-psw-pe-001"  = ["scem-d-vnt-psw-001", "10.130.33.240/28"]
      }
      nsg = {
        "scem-d-nsg-psw-app-001" = "scem-d-rgp-psw-001"
        "scem-d-nsg-psw-web-001" = "scem-d-rgp-psw-001"
        "scem-d-nsg-psw-db-001"  = "scem-d-rgp-psw-001"

        "scem-f-nsg-psw-app-001" = "scem-f-rgp-psw-001"
        "scem-f-nsg-psw-web-001" = "scem-f-rgp-psw-001"
        "scem-f-nsg-psw-db-001"  = "scem-f-rgp-psw-001"

        "scem-q-nsg-psw-app-001" = "scem-q-rgp-psw-001"
        "scem-q-nsg-psw-web-001" = "scem-q-rgp-psw-001"
        "scem-q-nsg-psw-db-001"  = "scem-q-rgp-psw-001"
      }

      nsgrule  = {}
      nsgrule1 = {}

      nsg-subnet-assoc = {
        "scem-d-nsg-psw-app-001" = "scem-d-sub-psw-app-001"
        "scem-d-nsg-psw-db-001"  = "scem-d-sub-psw-db-001"
        "scem-d-nsg-psw-web-001" = "scem-d-sub-psw-web-001"

        "scem-f-nsg-psw-app-001" = "scem-f-sub-psw-app-001"
        "scem-f-nsg-psw-db-001"  = "scem-f-sub-psw-db-001"
        "scem-f-nsg-psw-web-001" = "scem-f-sub-psw-web-001"

        "scem-q-nsg-psw-app-001" = "scem-q-sub-psw-app-001"
        "scem-q-nsg-psw-db-001"  = "scem-q-sub-psw-db-001"
        "scem-q-nsg-psw-web-001" = "scem-q-sub-psw-web-001"
      }
      route_table = {

        /*"scem-d-rot-psw-app-001" = "scem-d-rgp-psw-001"
          "scem-d-rot-psw-db-001"  = "scem-d-rgp-psw-001"
          "scem-d-rot-psw-web-001" = "scem-d-rgp-psw-001"
          "scem-d-rot-psw-pe-001"  = "scem-d-rgp-psw-001"
          "scem-f-rot-psw-app-001" = "scem-f-rgp-psw-001"
          "scem-f-rot-psw-db-001"  = "scem-f-rgp-psw-001"
          "scem-f-rot-psw-web-001" = "scem-f-rgp-psw-001"
          "scem-f-rot-psw-pe-001"  = "scem-f-rgp-psw-001"
          "scem-q-rot-psw-app-001" = "scem-q-rgp-psw-001"
          "scem-q-rot-psw-db-001"  = "scem-q-rgp-psw-001"
          "scem-q-rot-psw-web-001" = "scem-q-rgp-psw-001"
          "scem-q-rot-psw-pe-001"  = "scem-q-rgp-psw-001"*/
      }
      udr = {
        /*610  = ["scem-d-udr-fw-rotpswapp", "scem-d-rot-psw-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          810  = ["scem-d-udr-fw-rotpswdb", "scem-d-rot-psw-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1010 = ["scem-d-udr-fw-rotpswweb", "scem-d-rot-psw-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1210 = ["scem-f-udr-fw-rotpswapp", "scem-f-rot-psw-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1410 = ["scem-f-udr-fw-rotpswdb", "scem-f-rot-psw-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1610 = ["scem-f-udr-fw-rotpswweb", "scem-f-rot-psw-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          1810 = ["scem-q-udr-fw-rotpswapp", "scem-q-rot-psw-app-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2010 = ["scem-q-udr-fw-rotpswdb", "scem-q-rot-psw-db-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2210 = ["scem-q-udr-fw-rotpswweb", "scem-q-rot-psw-web-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2610 = ["scem-d-udr-fw-rotpswpe", "scem-d-rot-psw-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          2810 = ["scem-f-udr-fw-rotpswpe", "scem-f-rot-psw-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]
          3010 = ["scem-q-udr-fw-rotpswpe", "scem-q-rot-psw-pe-001", "0.0.0.0/0", "VirtualAppliance", "10.130.0.228"]*/
      }
      rt_assoc = {
        /*"scem-d-rot-psw-app-001" = "scem-d-sub-psw-app-001"
          "scem-d-rot-psw-db-001"  = "scem-d-sub-psw-db-001"
          "scem-d-rot-psw-web-001" = "scem-d-sub-psw-web-001"
          "scem-d-rot-psw-pe-001"  = "scem-d-sub-psw-pe-001"
          "scem-f-rot-psw-app-001" = "scem-f-sub-psw-app-001"
          "scem-f-rot-psw-db-001"  = "scem-f-sub-psw-db-001"
          "scem-f-rot-psw-web-001" = "scem-f-sub-psw-web-001"
          "scem-f-rot-psw-pe-001"  = "scem-f-sub-psw-pe-001"
          "scem-q-rot-psw-app-001" = "scem-q-sub-psw-app-001"
          "scem-q-rot-psw-db-001"  = "scem-q-sub-psw-db-001"
          "scem-q-rot-psw-web-001" = "scem-q-sub-psw-web-001"
          "scem-q-rot-psw-pe-001"  = "scem-q-sub-psw-pe-001"*/
      }
    }


  }

}
