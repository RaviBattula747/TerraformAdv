# terraform apply --var-file="prod.tfvars" --target=module.az-rg-connectivity --target=module.vnet-connectivity --target=module.snet-connectivity --target=module.dpr_virtual_network_link-connectivity --target=module.conn-connectivity --target=module.az-nsg-connectivity --target=module.az-nsg-rule-connectivity --target=module.link-Subnet-NSG-connectivity --target=module.az-rt-connectivity --target=module.az-rt-rule-connectivity --target=module.az-rt-rule1-connectivity --target=module.rt_assoc-connectivity 

# For DR deployments, ensure you are in right workspace by line 4 command and do line 5, other vise have to face huge problems
# terraform workspace select dr
# terraform apply --var-file="dr.tfvars" --target=module.az-rg-connectivity --target=module.vnet-connectivity --target=module.snet-connectivity --target=module.dpr_virtual_network_link-connectivity --target=module.conn-connectivity --target=module.az-nsg-connectivity --target=module.az-nsg-rule-connectivity --target=module.link-Subnet-NSG-connectivity --target=module.az-rt-connectivity --target=module.az-rt-rule-connectivity --target=module.az-rt-rule1-connectivity --target=module.rt_assoc-connectivity 

# for connectivity specific resources, use below
# --target=module.vwan --target=module.vhub --target=module.erg --target=module.az-pip-connectivity --target=module.cngfw --target=module.cngfwrs --target=module.az-rtintent --target=module.az-rtintent-eastus 
module "az-rg-connectivity" {
  for_each = { for k, v in local.select.rg : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  source   = "../../modules/network/rg"
  name     = each.key
  location = local.select.location
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "connectivity"
    SYSTEM_CODE     = "connectivity"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "vnet-connectivity" {
  #for_each = local.select.virtual_network
  for_each            = { for k, v in local.select.virtual_network : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = local.select.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "snet-connectivity" {
  for_each = { for k, v in local.select.subnet : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-connectivity[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.connectivity
  }
}


module "dpr_virtual_network_link-connectivity" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k, v in local.select.dpr.dpr_virtual_network_link : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  name                      = each.key
  dns_forwarding_ruleset_id = each.value
  virtual_network_id        = module.vnet-connectivity[each.key].out.id
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "conn-connectivity" {
  #for_each = toset(local.select.hubpeers)
  #for_each = toset([for peer in local.select.hubpeers : peer if split("-", peer)[3] == "connectivity" )
  for_each                  = { for peer in toset(local.select.hubpeers) : peer => peer if split("-", peer)[3] == "connectivity" && local.select.env == "prod" }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.select.vhub_id
  remote_virtual_network_id = module.vnet-connectivity[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-nsg-connectivity" {
  for_each            = { for k, v in local.select.nsg : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = local.select.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.connectivity
  }
}


module "az-nsg-rule-connectivity" {
  for_each                     = { for k, v in local.select.nsgrule : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
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
  resource_group_name          = module.az-nsg-connectivity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-nsg-rule-connectivity1" {
  for_each                    = { for k, v in local.select.nsgrule1 : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
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
  resource_group_name         = module.az-nsg-connectivity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.connectivity
  }
}


module "link-Subnet-NSG-connectivity" {
  #for_each = local.select.nsg-subnet-assoc
  for_each = { for k, v in local.select.nsg-subnet-assoc : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-connectivity[each.value].out.id
  network_security_group_id = module.az-nsg-connectivity[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-rt-connectivity" {
  for_each = { for k, v in local.select.route_table : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = local.select.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-rt-rule-connectivity" {
  for_each               = { for k, v in local.select.udr : k => v if length(v) == 5 && split("-", v[1])[3] == "connectivity" && local.select.env == "prod" }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-connectivity[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-rt-rule1-connectivity" {
  for_each            = { for k, v in local.select.udr : k => v if length(v) == 4 && split("-", v[1])[3] == "connectivity" && local.select.env == "prod" }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-connectivity[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "rt_assoc-connectivity" {
  for_each       = { for k, v in local.select.rt_assoc : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-connectivity[each.value].out.id
  route_table_id = module.az-rt-connectivity[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.connectivity
  }
}


###############################################################
#uncommon resources
###############################################################

module "vwan" {
  source              = "../../modules/network/vwan"
  count               = local.select.location == "West US 3" ? local.select.env == "prod" ? 1 : 0 : 0
  name                = local.select.vwan.name
  resource_group_name = local.select.vwan.resource_group_name
  location            = local.select.location
  type                = "Standard"
  providers = {
    azurerm = azurerm.connectivity
  }
  depends_on = [module.az-rg-connectivity]
}

module "vhub" {
  source              = "../../modules/network/vhub"
  count               = local.select.env == "prod" ? 1 : 0
  name                = local.select.vhub.name
  resource_group_name = local.select.vhub.resource_group_name
  location            = local.select.location
  virtual_wan_id      = local.select.vhub.vwan_id
  address_prefix      = local.select.vhub.address_prefix
  providers = {
    azurerm = azurerm.connectivity
  }
  depends_on = [module.vwan]
}

module "erg" {
  source              = "../../modules/network/erg"
  count               = local.select.env == "prod" ? 1 : 0
  name                = local.select.erg.name
  location            = local.select.location
  resource_group_name = local.select.erg.resource_group_name
  virtual_hub_id      = local.select.vhub_id
  scale_units         = local.select.erg.scale_units
  providers = {
    azurerm = azurerm.connectivity
  }
  depends_on = [module.vhub]
}

module "az-pip-connectivity" {
  for_each             = { for k, v in local.select.pips : k => v if split("-", k)[3] == "connectivity" && local.select.env == "prod" }
  source               = "../../modules/network/pip"
  name                 = each.key
  location             = local.select.location
  resource_group_name  = each.value
  allocation_method    = "Static"
  sku                  = "Standard"
  ddos_protection_mode = "Disabled"
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "cngfw" {
  source         = "../../modules/network/fw/firewall"
  for_each       = { for k, v in local.select.fw : k => v if local.select.env == "prod" }
  name           = each.value
  virtual_hub_id = local.select.vhub_id
  #depends_on = [module.vhub]
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "cngfwrs" {
  source                       = "../../modules/network/fw/pmrulestack"
  for_each                     = { for k, v in local.select.panoramastack : k => v if local.select.env == "prod" }
  name                         = each.key
  resource_group_name          = each.value.resource_group_name
  location                     = local.select.location
  public_ip_address_ids        = each.value.public_ip_address_ids
  trusted_address_ranges       = each.value.trusted_address_ranges
  virtual_hub_id               = local.select.vhub_id
  network_virtual_appliance_id = module.cngfw[each.value.network_virtual_appliance_id].out.id
  panorama_base64_config       = each.value.panorama_base64_config
  providers = {
    azurerm = azurerm.connectivity
  }
}

module "az-rtintent" {
  #local.select.location == "West US 3" &&
  source         = "../../modules/network/rtintent"
  count          = local.select.location == "West US 3" && local.select.env == "prod" ? 1 : 0
  virtual_hub_id = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-p-rgp-connectivity-001/providers/Microsoft.Network/virtualHubs/scem-p-vhb-connectivity-001"
  # next_hop = module.cngfw["fw1"].out.id
  next_hop = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-p-rgp-connectivity-001/providers/Microsoft.Network/networkVirtualAppliances/scem-p-cfw-elz-001-westus3pa"
  providers = {
    azurerm = azurerm.connectivity
  }
}
#virtual_hub_id = local.select.vhub_id
module "az-rtintent-eastus" {
  source         = "../../modules/network/rtintent"
  count          = local.select.location == "East US" ? 1 : 0
  virtual_hub_id = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-b-rgp-connectivity-001-eastus/providers/Microsoft.Network/virtualHubs/scem-b-vhb-connectivity-001-eastus"
  next_hop       = "/subscriptions/5d847d89-4018-49b2-9c82-ed4fe6ffb6e5/resourceGroups/scem-b-rgp-connectivity-001-eastus/providers/Microsoft.Network/networkVirtualAppliances/scem-b-cfw-elz-001-eastuspa"
  providers = {
    azurerm = azurerm.connectivity
  }
}