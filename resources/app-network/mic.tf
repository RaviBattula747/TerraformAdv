module "az-rg-mic" {
  for_each = { for k, v in local.app.mic.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "MICAS"
    SYSTEM_CODE     = "mic"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "Priority_4"
  }
  providers = {
    azurerm = azurerm.mic
  }
}

module "vnet-mic" {
  for_each            = { for k, v in local.app.mic.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-mic[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.mic
  }
}

module "snet-mic" {
  for_each = { for k, v in local.app.mic.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-mic[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.mic
  }
}


module "dpr_virtual_network_link-mic" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.app.mic.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = split("-", each.value)[1] == "p" ? local.dpr-link : split("-", each.value)[1] == "b" ? local.drdpr-link : "invalid name"
  virtual_network_id        = module.vnet-mic[each.key].out.id
  providers = {
    azurerm = azurerm.mic
  }
}

module "conn-mic" {
  for_each                  = { for peer in toset(local.app.mic.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = split("-", each.value)[1] == "p" ? local.vhub_id : local.drvhub_id
  remote_virtual_network_id = module.vnet-mic[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.mic
  }
}

module "az-nsg-mic" {
  for_each            = { for k, v in local.app.mic.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-mic[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.mic
  }
}


module "az-nsg-rule-mic" {
  for_each                     = { for k, v in local.app.mic.nsgrule : k => v }
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
  resource_group_name          = module.az-nsg-mic[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.mic
  }
}

module "az-nsg-rule-mic1" {
  for_each                    = { for k, v in local.app.mic.nsgrule1 : k => v }
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
  resource_group_name         = module.az-nsg-mic[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.mic
  }
}


module "link-Subnet-NSG-mic" {
  for_each = { for k, v in local.app.mic.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-mic[each.value].out.id
  network_security_group_id = module.az-nsg-mic[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.mic
  }
}


module "az-rt-mic" {
  for_each = { for k, v in local.app.mic.route_table : k => v }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = module.az-rg-mic[each.value].out.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.mic
  }
}

module "az-rt-rule-mic" {
  for_each               = { for k, v in local.app.mic.udr : k => v if length(v) == 5 }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-mic[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.mic
  }
}

module "az-rt-rule1-mic" {
  for_each            = { for k, v in local.app.mic.udr : k => v if length(v) == 4 }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-mic[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.mic
  }
}

module "rt_assoc-mic" {
  for_each       = { for k, v in local.app.mic.rt_assoc : k => v }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-mic[each.value].out.id
  route_table_id = module.az-rt-mic[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.mic
  }
}

#===========================================================================================================================
#                                             NON-PROD ENV MODULES
#===========================================================================================================================

module "az-rg-mic-np" {
  for_each = { for k, v in local.napp.mic.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "Adobe Experience Manager"
    SYSTEM_CODE     = "mic"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "Non-Prod"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "vnet-mic-np" {
  for_each            = { for k, v in local.napp.mic.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-mic-np[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "snet-mic-np" {
  for_each = { for k, v in local.napp.mic.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-mic-np[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "dpr_virtual_network_link-mic-np" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.napp.mic.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = local.dpr-link
  virtual_network_id        = module.vnet-mic-np[each.key].out.id
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "conn-mic-np" {
  for_each                  = { for peer in toset(local.napp.mic.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.vhub_id
  remote_virtual_network_id = module.vnet-mic-np[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "az-nsg-mic-np" {
  for_each            = { for k, v in local.napp.mic.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-mic-np[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.mic-np
  }
}


module "az-nsg-rule-mic-np" {
  for_each                     = { for k, v in local.napp.mic.nsgrule : k => v }
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
  resource_group_name          = module.az-nsg-mic-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "az-nsg-rule-mic-np1" {
  for_each                    = { for k, v in local.napp.mic.nsgrule1 : k => v }
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
  resource_group_name         = module.az-nsg-mic-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.mic-np
  }
}


module "link-Subnet-NSG-mic-np" {
  #for_each = local.app.mic.nsg-subnet-assoc
  for_each = { for k, v in local.napp.mic.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-mic-np[each.value].out.id
  network_security_group_id = module.az-nsg-mic-np[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "az-rt-mic-np" {
  for_each = { for k, v in local.napp.mic.route_table : k => v }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = module.az-rg-mic-np[each.value].out.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "az-rt-rule-mic-np" {
  for_each               = { for k, v in local.napp.mic.udr : k => v if length(v) == 5 }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-mic-np[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "az-rt-rule1-mic-np" {
  for_each            = { for k, v in local.napp.mic.udr : k => v if length(v) == 4 }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-mic-np[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.mic-np
  }
}

module "rt_assoc-mic-np" {
  for_each       = { for k, v in local.napp.mic.rt_assoc : k => v }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-mic-np[each.value].out.id
  route_table_id = module.az-rt-mic-np[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.mic-np
  }
}