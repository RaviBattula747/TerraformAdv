module "az-rg-ase" {
  for_each = { for k, v in local.app.ase.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "APPSENSE"
    SYSTEM_CODE     = "ase"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "3"
  }
  providers = {
    azurerm = azurerm.ase
  }
}

module "vnet-ase" {
  for_each            = { for k, v in local.app.ase.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-ase[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.ase
  }
}

module "snet-ase" {
  for_each = { for k, v in local.app.ase.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-ase[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.ase
  }
}


module "dpr_virtual_network_link-ase" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.app.ase.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = split("-", each.value)[1] == "p" ? local.dpr-link : split("-", each.value)[1] == "b" ? local.drdpr-link : "invalid name"
  virtual_network_id        = module.vnet-ase[each.key].out.id
  providers = {
    azurerm = azurerm.ase
  }
}

module "conn-ase" {
  for_each                  = { for peer in toset(local.app.ase.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = split("-", each.value)[1] == "p" ? local.vhub_id : split("-", each.value)[1] == "b" ? local.drvhub_id : "invalid name"
  remote_virtual_network_id = module.vnet-ase[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.ase
  }
}

module "az-nsg-ase" {
  for_each            = { for k, v in local.app.ase.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-ase[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.ase
  }
}


module "az-nsg-rule-ase" {
  for_each                     = { for k, v in local.app.ase.nsgrule : k => v }
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
  resource_group_name          = module.az-nsg-ase[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.ase
  }
}

module "az-nsg-rule-ase1" {
  for_each                    = { for k, v in local.app.ase.nsgrule1 : k => v }
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
  resource_group_name         = module.az-nsg-ase[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.ase
  }
}


module "link-Subnet-NSG-ase" {
  for_each = { for k, v in local.app.ase.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-ase[each.value].out.id
  network_security_group_id = module.az-nsg-ase[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.ase
  }
}


module "az-rt-ase" {
  for_each = { for k, v in local.app.ase.route_table : k => v }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = module.az-rg-ase[each.value].out.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.ase
  }
}

module "az-rt-rule-ase" {
  for_each               = { for k, v in local.app.ase.udr : k => v if length(v) == 5 }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-ase[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.ase
  }
}

module "az-rt-rule1-ase" {
  for_each            = { for k, v in local.app.ase.udr : k => v if length(v) == 4 }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-ase[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.ase
  }
}

module "rt_assoc-ase" {
  for_each       = { for k, v in local.app.ase.rt_assoc : k => v }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-ase[each.value].out.id
  route_table_id = module.az-rt-ase[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.ase
  }
}

#===========================================================================================================================
#                                             NON-PROD ENV MODULES
#===========================================================================================================================

module "az-rg-ase-np" {
  for_each = { for k, v in local.napp.ase.rg : k => v }
  source   = "../../modules/network/rg"
  name     = each.key
  location = each.value
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "APPSENSE"
    SYSTEM_CODE     = "ase"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "Non-Prod"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "3"
  }
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "vnet-ase-np" {
  for_each            = { for k, v in local.napp.ase.virtual_network : k => v }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = module.az-rg-ase-np[each.value.resource_group_name].out.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "snet-ase-np" {
  for_each = { for k, v in local.napp.ase.subnet : k => v }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-ase-np[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "dpr_virtual_network_link-ase-np" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k in toset(local.napp.ase.dpr_virtual_network_link) : k => k }
  name                      = each.key
  dns_forwarding_ruleset_id = local.dpr-link
  virtual_network_id        = module.vnet-ase-np[each.key].out.id
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "conn-ase-np" {
  for_each                  = { for peer in toset(local.napp.ase.hubpeers) : peer => peer }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.vhub_id
  remote_virtual_network_id = module.vnet-ase-np[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "az-nsg-ase-np" {
  for_each            = { for k, v in local.napp.ase.nsg : k => v }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = module.az-rg-ase-np[each.value].out.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.ase-np
  }
}


module "az-nsg-rule-ase-np" {
  for_each                     = { for k, v in local.napp.ase.nsgrule : k => v }
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
  resource_group_name          = module.az-nsg-ase-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "az-nsg-rule-ase-np1" {
  for_each                    = { for k, v in local.napp.ase.nsgrule1 : k => v }
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
  resource_group_name         = module.az-nsg-ase-np[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.ase-np
  }
}


module "link-Subnet-NSG-ase-np" {
  #for_each = local.app.ase.nsg-subnet-assoc
  for_each = { for k, v in local.napp.ase.nsg-subnet-assoc : k => v }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-ase-np[each.value].out.id
  network_security_group_id = module.az-nsg-ase-np[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "az-rt-ase-np" {
  for_each = { for k, v in local.napp.ase.route_table : k => v }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = module.az-rg-ase-np[each.value].out.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "az-rt-rule-ase-np" {
  for_each               = { for k, v in local.napp.ase.udr : k => v if length(v) == 5 }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-ase-np[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "az-rt-rule1-ase-np" {
  for_each            = { for k, v in local.napp.ase.udr : k => v if length(v) == 4 }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-ase-np[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.ase-np
  }
}

module "rt_assoc-ase-np" {
  for_each       = { for k, v in local.napp.ase.rt_assoc : k => v }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-ase-np[each.value].out.id
  route_table_id = module.az-rt-ase-np[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.ase-np
  }
}
