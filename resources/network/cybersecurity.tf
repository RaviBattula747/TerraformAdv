# terraform apply --var-file="prod.tfvars" --target=module.az-rg-cybersecurity --target=module.vnet-cybersecurity --target=module.snet-cybersecurity --target=module.dpr_virtual_network_link-cybersecurity --target=module.conn-cybersecurity --target=module.az-nsg-cybersecurity --target=module.az-nsg-rule-cybersecurity --target=module.link-Subnet-NSG-cybersecurity --target=module.az-rt-cybersecurity --target=module.az-rt-rule-cybersecurity --target=module.az-rt-rule1-cybersecurity --target=module.rt_assoc-cybersecurity 

# For DR deployments, ensure you are in right workspace by line 4 command and do line 5, other vise have to face huge problems
# terraform workspace select dr
# terraform apply --var-file="prod.tfvars" --target=module.az-rg-cybersecurity --target=module.vnet-cybersecurity --target=module.snet-cybersecurity --target=module.dpr_virtual_network_link-cybersecurity --target=module.conn-cybersecurity --target=module.az-nsg-cybersecurity --target=module.az-nsg-rule-cybersecurity --target=module.link-Subnet-NSG-cybersecurity --target=module.az-rt-cybersecurity --target=module.az-rt-rule-cybersecurity --target=module.az-rt-rule1-cybersecurity --target=module.rt_assoc-cybersecurity 

module "az-rg-cybersecurity" {
  for_each = { for k, v in local.select.rg : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
  source   = "../../modules/network/rg"
  name     = each.key
  location = local.select.location
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "cybersecurity"
    SYSTEM_CODE     = "cybersecurity"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "vnet-cybersecurity" {
  for_each            = { for k, v in local.select.virtual_network : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = local.select.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "snet-cybersecurity" {
  for_each = { for k, v in local.select.subnet : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-cybersecurity[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}


module "dpr_virtual_network_link-cybersecurity" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k, v in local.select.dpr.dpr_virtual_network_link : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
  name                      = each.key
  dns_forwarding_ruleset_id = each.value
  virtual_network_id        = module.vnet-cybersecurity[each.key].out.id
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "conn-cybersecurity" {
  for_each                  = { for peer in toset(local.select.hubpeers) : peer => peer if split("-", peer)[3] == "cybersecurity" && local.select.env == "prod" }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.select.vhub_id
  remote_virtual_network_id = module.vnet-cybersecurity[each.value].out.id
  internet_security_enabled = true
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "az-nsg-cybersecurity" {
  for_each            = { for k, v in local.select.nsg : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = local.select.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}


module "az-nsg-rule-cybersecurity" {
  for_each                     = { for k, v in local.select.nsgrule : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
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
  resource_group_name          = module.az-nsg-cybersecurity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "az-nsg-rule-cybersecurity1" {
  for_each                    = { for k, v in local.select.nsgrule1 : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
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
  resource_group_name         = module.az-nsg-cybersecurity[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}


module "link-Subnet-NSG-cybersecurity" {
  #for_each = local.select.nsg-subnet-assoc
  for_each = { for k, v in local.select.nsg-subnet-assoc : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-cybersecurity[each.value].out.id
  network_security_group_id = module.az-nsg-cybersecurity[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "az-rt-cybersecurity" {
  for_each = { for k, v in local.select.route_table : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = local.select.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "az-rt-rule-cybersecurity" {
  for_each               = { for k, v in local.select.udr : k => v if length(v) == 5 && split("-", v[1])[3] == "cybersecurity" && local.select.env == "prod" }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-cybersecurity[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "az-rt-rule1-cybersecurity" {
  for_each            = { for k, v in local.select.udr : k => v if length(v) == 4 && split("-", v[1])[3] == "cybersecurity" && local.select.env == "prod" }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-cybersecurity[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}

module "rt_assoc-cybersecurity" {
  for_each       = { for k, v in local.select.rt_assoc : k => v if split("-", k)[3] == "cybersecurity" && local.select.env == "prod" }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-cybersecurity[each.value].out.id
  route_table_id = module.az-rt-cybersecurity[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.cybersecurity
  }
}


