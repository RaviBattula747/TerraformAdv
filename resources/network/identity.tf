# terraform apply --var-file="prod.tfvars" --target=module.az-rg-identity --target=module.vnet-identity --target=module.snet-identity --target=module.dpr_virtual_network_link-identity --target=module.conn-identity --target=module.az-nsg-identity --target=module.az-nsg-rule-identity --target=module.link-Subnet-NSG-identity --target=module.az-rt-identity --target=module.az-rt-rule-identity --target=module.az-rt-rule1-identity --target=module.rt_assoc-identity 

# For DR deployments, ensure you are in right workspace by line 4 command and do line 5, other vise have to face huge problems
# terraform workspace select dr
# terraform apply --var-file="dr.tfvars" --target=module.az-rg-identity --target=module.vnet-identity --target=module.snet-identity --target=module.dpr_virtual_network_link-identity --target=module.conn-identity --target=module.az-nsg-identity --target=module.az-nsg-rule-identity --target=module.az-nsg-rule-identity1 --target=module.link-Subnet-NSG-identity --target=module.az-rt-identity --target=module.az-rt-rule-identity --target=module.az-rt-rule1-identity --target=module.rt_assoc-identity 

# for identity specific resources, use below extensio
# --target=module.dpr --target=module.dpr-inputendpointn --target=module.dpr-outputendpoint --target=module.dpr-forwardingruleset --target=module.dpr-forwardingrule

module "az-rg-identity" {
  for_each = { for k, v in local.select.rg : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
  source   = "../../modules/network/rg"
  name     = each.key
  location = local.select.location
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "identity"
    SYSTEM_CODE     = "identity"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.identity
  }
}

module "vnet-identity" {
  for_each            = { for k, v in local.select.virtual_network : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = local.select.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.identity
  }
}

module "snet-identity" {
  for_each = { for k, v in local.select.subnet : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-identity[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.identity
  }
  #depends_on = [module.vnet]
}

module "dpr_virtual_network_link-identity" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k, v in local.select.dpr.dpr_virtual_network_link : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
  name                      = each.key
  dns_forwarding_ruleset_id = each.value
  virtual_network_id        = module.vnet-identity[each.key].out.id
  providers = {
    azurerm = azurerm.identity
  }
}

module "conn-identity" {
  #for_each = toset(local.select.hubpeers)
  #for_each = toset([for peer in local.select.hubpeers : peer if split("-", peer)[3] == "identity" )
  for_each                  = { for peer in toset(local.select.hubpeers) : peer => peer if split("-", peer)[3] == "identity" && local.select.env == "prod" }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.select.vhub_id
  remote_virtual_network_id = module.vnet-identity[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.identity
  }
}

module "az-nsg-identity" {
  for_each            = { for k, v in local.select.nsg : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = local.select.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.identity
  }
}


module "az-nsg-rule-identity" {
  for_each                     = { for k, v in local.select.nsgrule : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
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
  resource_group_name          = module.az-nsg-identity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.identity
  }
}

module "az-nsg-rule-identity1" {
  for_each                    = { for k, v in local.select.nsgrule1 : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
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
  resource_group_name         = module.az-nsg-identity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.identity
  }
}

module "link-Subnet-NSG-identity" {
  #for_each = local.select.nsg-subnet-assoc
  for_each = { for k, v in local.select.nsg-subnet-assoc : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-identity[each.value].out.id
  network_security_group_id = module.az-nsg-identity[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.identity
  }
}

module "az-rt-identity" {
  for_each = { for k, v in local.select.route_table : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = local.select.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.identity
  }
}

module "az-rt-rule-identity" {
  for_each               = { for k, v in local.select.udr : k => v if length(v) == 5 && split("-", v[1])[3] == "identity" && local.select.env == "prod" }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-identity[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.identity
  }
}

module "az-rt-rule1-identity" {
  for_each            = { for k, v in local.select.udr : k => v if length(v) == 4 && split("-", v[1])[3] == "identity" && local.select.env == "prod" }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-identity[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.identity
  }
}

module "rt_assoc-identity" {
  for_each       = { for k, v in local.select.rt_assoc : k => v if split("-", k)[3] == "identity" && local.select.env == "prod" }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-identity[each.value].out.id
  route_table_id = module.az-rt-identity[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.identity
  }
}



#########################################################
#uncommon resources
########################################################

module "dpr" {
  source              = "../../modules/network/dpr/dpr"
  count               = local.select.env == "prod" ? 1 : 0
  name                = local.select.dpr.name
  resource_group_name = local.select.dpr.resource_group_name
  location            = local.select.location
  virtual_network_id  = module.vnet-identity[local.select.dpr.virtual_network_id].out.id
  providers = {
    azurerm = azurerm.identity
  }
  #depends_on = [module.vnet]
}

module "dpr-inputendpoint" {
  source                  = "../../modules/network/dpr/inputendpoint"
  for_each                = { for k, v in local.select.dpr.inputendpoint : k => v if local.select.env == "prod" }
  name                    = each.key
  private_dns_resolver_id = module.dpr[0].id
  location                = local.select.location
  subnet_id               = module.snet-identity[each.value[1]].out.id
  providers = {
    azurerm = azurerm.identity
  }
}

module "dpr-outputendpoint" {
  for_each                = { for k, v in local.select.dpr.outputendpoint : k => v if local.select.env == "prod" }
  source                  = "../../modules/network/dpr/outputendpoint"
  name                    = each.key
  private_dns_resolver_id = module.dpr[0].id
  location                = local.select.location
  subnet_id               = module.snet-identity[each.value[1]].out.id
  providers = {
    azurerm = azurerm.identity
  }
}
#private_dns_resolver_outbound_endpoint_ids = [module.dpr-outputendpoint[each.value[1]].out.id]
#  private_dns_resolver_outbound_endpoint_ids = [ for endpoint in each.value[1] : module.dpr-outputendpoint[endpoint].out.id ]
#for endpoint_id in slice(each.value, 1, length(each.value) - 3) : module.dpr-outputendpoint[endpoint_id].out.id   ]

module "dpr-forwardingruleset" {
  source                                     = "../../modules/network/dpr/forwardingruleset"
  for_each                                   = { for k, v in local.select.dpr.forwardingruleset : k => v if local.select.env == "prod" }
  name                                       = each.key
  resource_group_name                        = each.value[0]
  location                                   = local.select.location
  private_dns_resolver_outbound_endpoint_ids = [module.dpr-outputendpoint[each.value[1]].out.id]
  providers = {
    azurerm = azurerm.identity
  }
}

module "dpr-forwardingrule" {
  source                    = "../../modules/network/dpr/forwardingrule"
  for_each                  = { for k, v in local.select.dpr.forwardingrule : k => v if local.select.env == "prod" }
  name                      = each.key
  dns_forwarding_ruleset_id = module.dpr-forwardingruleset[each.value[0]].out.id
  domain_name               = each.value[1]
  providers = {
    azurerm = azurerm.identity
  }
}

