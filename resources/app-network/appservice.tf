module "az-rg-appservice" {
  for_each = { for k, v in local.app.appservice.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = split("-",each.key)[3] == "emp" ? "eDMRM Migration Planner" : "CCC watchtower"
    SYSTEM_CODE     = split("-",each.key)[3] == "emp" ? "eDMRM Migration Planner" : "CCC watchtower"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = split("-",each.key)[3] == "emp" ? "4" : "3"
  }
  providers = {
    azurerm = azurerm.appservice
  }
}

module "vnet-appservice" {
  for_each            = { for k, v in local.app.appservice.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-appservice[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.appservice
  }
}

module "snet-appservice" {
  for_each = { for k, v in local.app.appservice.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-appservice[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.appservice
  }
}


module "dpr_virtual_network_link-appservice" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.app.appservice.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = split("-", each.value)[1] == "p" ? local.dpr-link : split("-", each.value)[1] == "b" ? local.drdpr-link : "invalid name"
  virtual_network_id        = module.vnet-appservice[each.key].out.id
  providers = {
    azurerm = azurerm.appservice
  }
}

module "conn-appservice" {
  for_each                  = { for peer in toset(local.app.appservice.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = split("-", each.value)[1] == "p" ? local.vhub_id : local.drvhub_id
  remote_virtual_network_id = module.vnet-appservice[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.appservice
  }
}

module "az-nsg-appservice" {
  for_each            = { for k, v in local.app.appservice.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-appservice[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.appservice
  }
}


module "az-nsg-rule-appservice" {
  for_each                     = { for k, v in local.app.appservice.nsgrule : k => v }
  source                       = "../../modules/network/nsgrule/nsgrule1"
  name                         = "scem-ngr-${substr(each.key, 0, 1)}b${substr(each.key, 1, 1)}-${each.value[0] == "*" ? "any" : lower(each.value[0])}-${tonumber(substr(each.key, 2, 4))}"
  priority                     = substr(each.key, 2, 4)
  direction                    = substr(each.key, 0, 1) == "i" ? "Inbound" : substr(each.key, 0, 1) == "o" ? "Outbound" : "key first letter at nsgrule should be either 'i' or 'o' representing inbound or outbound"
  access                       = substr(each.key, 1, 1) == "a" ? "Allow" : substr(each.key, 1, 1) == "d" ? "Deny" : "key first letter at nsgrule should be either 'a' or 'd' representing allow or deny"
  protocol                     = each.value[0]
  source_port_range            = "*"
  destination_port_ranges      = each.value[1]
  source_address_prefixes      = each.value[2]
  destination_address_prefixes = each.value[3]
  resource_group_name          = module.az-nsg-appservice[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.appservice
  }
}

module "az-nsg-rule-appservice1" {
  for_each                    = { for k, v in local.app.appservice.nsgrule1 : k => v }
  source                      = "../../modules/network/nsgrule/nsgrule2"
  name                        = "scem-ngr-${substr(each.key, 0, 1)}b${substr(each.key, 1, 1)}-${each.value[0] == "*" ? "any" : lower(each.value[0])}-${tonumber(substr(each.key, 2, 4))}" # each.value[0]
  priority                    = substr(each.key, 2, 4)
  direction                   = substr(each.key, 0, 1) == "i" ? "Inbound" : substr(each.key, 0, 1) == "o" ? "Outbound" : "key first letter at nsgrule should be either 'i' or 'o' representing inbound or outbound"
  access                      = substr(each.key, 1, 1) == "a" ? "Allow" : substr(each.key, 1, 1) == "d" ? "Deny" : "key first letter at nsgrule should be either 'a' or 'd' representing allow or deny"
  protocol                    = each.value[0]
  source_port_range           = "*"
  destination_port_ranges     = each.value[1]
  source_address_prefix       = each.value[2]
  destination_address_prefix  = each.value[3]
  resource_group_name         = module.az-nsg-appservice[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.appservice
  }
}


module "link-Subnet-NSG-appservice" {
  for_each = { for k, v in local.app.appservice.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-appservice[each.value].out.id
  network_security_group_id = module.az-nsg-appservice[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.appservice
  }
}

#===========================================================================================================================
#                                             NON-PROD ENV MODULES
#===========================================================================================================================

module "az-rg-appservice-np" {
  for_each = { for k, v in local.napp.appservice.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "appservice"
    SYSTEM_CODE     = "appservice"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "Non-Prod"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "vnet-appservice-np" {
  for_each            = { for k, v in local.napp.appservice.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-appservice-np[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "snet-appservice-np" {
  for_each = { for k, v in local.napp.appservice.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-appservice-np[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "dpr_virtual_network_link-appservice-np" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.napp.appservice.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = local.dpr-link
  virtual_network_id        = module.vnet-appservice-np[each.key].out.id
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "conn-appservice-np" {
  for_each                  = { for peer in toset(local.napp.appservice.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.vhub_id
  remote_virtual_network_id = module.vnet-appservice-np[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "az-nsg-appservice-np" {
  for_each            = { for k, v in local.napp.appservice.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-appservice-np[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.appservice-np
  }
}


module "az-nsg-rule-appservice-np" {
  for_each                     = { for k, v in local.napp.appservice.nsgrule : k => v }
  source                       = "../../modules/network/nsgrule/nsgrule1"
  name                         = "scem-ngr-${substr(each.key, 0, 1)}b${substr(each.key, 1, 1)}-${each.value[0] == "*" ? "any" : lower(each.value[0])}-${tonumber(substr(each.key, 2, 4))}"
  priority                     = substr(each.key, 2, 4)
  direction                    = substr(each.key, 0, 1) == "i" ? "Inbound" : substr(each.key, 0, 1) == "o" ? "Outbound" : "key first letter at nsgrule should be either 'i' or 'o' representing inbound or outbound"
  access                       = substr(each.key, 1, 1) == "a" ? "Allow" : substr(each.key, 1, 1) == "d" ? "Deny" : "key first letter at nsgrule should be either 'a' or 'd' representing allow or deny"
  protocol                     = each.value[0]
  source_port_range            = "*"
  destination_port_ranges      = each.value[1]
  source_address_prefixes      = each.value[2]
  destination_address_prefixes = each.value[3]
  resource_group_name          = module.az-nsg-appservice-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "az-nsg-rule-appservice-np1" {
  for_each                    = { for k, v in local.napp.appservice.nsgrule1 : k => v }
  source                      = "../../modules/network/nsgrule/nsgrule2"
  name                        = "scem-ngr-${substr(each.key, 0, 1)}b${substr(each.key, 1, 1)}-${each.value[0] == "*" ? "any" : lower(each.value[0])}-${tonumber(substr(each.key, 2, 4))}"
  priority                    = substr(each.key, 2, 4)
  direction                   = substr(each.key, 0, 1) == "i" ? "Inbound" : substr(each.key, 0, 1) == "o" ? "Outbound" : "key first letter at nsgrule should be either 'i' or 'o' representing inbound or outbound"
  access                      = substr(each.key, 1, 1) == "a" ? "Allow" : substr(each.key, 1, 1) == "d" ? "Deny" : "key first letter at nsgrule should be either 'a' or 'd' representing allow or deny"
  protocol                    = each.value[0]
  source_port_range           = "*"
  destination_port_ranges     = each.value[1]
  source_address_prefix       = each.value[2]
  destination_address_prefix  = each.value[3]
  resource_group_name         = module.az-nsg-appservice-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.appservice-np
  }
}


module "link-Subnet-NSG-appservice-np" {
  #for_each = local.app.appservice.nsg-subnet-assoc
  for_each = { for k, v in local.napp.appservice.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-appservice-np[each.value].out.id
  network_security_group_id = module.az-nsg-appservice-np[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "az-rt-appservice-np" {
  for_each = { for k, v in local.napp.appservice.route_table : k => v }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = module.az-rg-appservice-np[each.value].out.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "az-rt-rule-appservice-np" {
  for_each               = { for k, v in local.napp.appservice.udr : k => v if length(v) == 5 }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-appservice-np[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "az-rt-rule1-appservice-np" {
  for_each            = { for k, v in local.napp.appservice.udr : k => v if length(v) == 4 }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-appservice-np[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.appservice-np
  }
}

module "rt_assoc-appservice-np" {
  for_each       = { for k, v in local.napp.appservice.rt_assoc : k => v }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-appservice-np[each.value].out.id
  route_table_id = module.az-rt-appservice-np[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.appservice-np
  }
}
