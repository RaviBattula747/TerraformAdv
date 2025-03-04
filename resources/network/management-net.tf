# terraform apply --var-file="prod.tfvars" --target=module.az-rg-management --target=module.vnet-management --target=module.snet-management --target=module.dpr_virtual_network_link-management --target=module.conn-management --target=module.az-nsg-management --target=module.az-nsg-rule-management --target=module.link-Subnet-NSG-management --target=module.az-rt-management --target=module.az-rt-rule-management --target=module.az-rt-rule1-management --target=module.rt_assoc-management 

# For DR deployments, ensure you are in right workspace by line 4 command and do line 5, other vise have to face huge problems
# terraform workspace select dr
# terraform apply --var-file="dr.tfvars" --target=module.az-rg-management --target=module.vnet-management --target=module.snet-management --target=module.dpr_virtual_network_link-management --target=module.conn-management --target=module.az-nsg-management --target=module.az-nsg-rule-management --target=module.link-Subnet-NSG-management --target=module.az-rt-management --target=module.az-rt-rule-management --target=module.az-rt-rule1-management --target=module.rt_assoc-management

# for management specific resources, use below extension 
# for westus 3 : --target=module.apg --target=module.az-bastion --target=module.az-pip-management 
# for east us  : --target=module.apg --target=module.az-bastion-eastus --target=module.az-pip-management

module "az-rg-management" {
  for_each = { for k, v in local.select.rg : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  source   = "../../modules/network/rg"
  name     = each.key
  location = local.select.location
  tags = {
    PROJECT_CONTACT = "Sindhura Raja"
    CMDB_CI_NAME    = "management"
    SYSTEM_CODE     = "management"
    SAP_COST_CENTER = "F530351"
    RESOURCE_TYPE   = "production"
    PORTFOLIO       = "Enterprise"
    OPERATING_UNIT  = "Enterprise"
    PRIORITY        = "1"
  }
  providers = {
    azurerm = azurerm.management
  }
}

module "vnet-management" {
  for_each            = { for k, v in local.select.virtual_network : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  source              = "../../modules/network/vnet"
  name                = each.key
  address_space       = each.value.address_space
  location            = local.select.location
  resource_group_name = each.value.resource_group_name
  providers = {
    azurerm = azurerm.management
  }
}

module "snet-management" {
  for_each = { for k, v in local.select.subnet : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }

  source               = "../../modules/network/snet"
  name                 = each.key
  resource_group_name  = module.vnet-management[each.value[0]].vnet_resource_group_name
  virtual_network_name = each.value[0]
  address_prefixes     = [each.value[1]]
  providers = {
    azurerm = azurerm.management
  }
}

module "snet-bastion" {
  count                = local.select.location == "West US 3" && local.select.env == "prod" ? 1 : 0
  source               = "../../modules/network/snet"
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.vnet-management["scem-p-vnt-management-001"].vnet_resource_group_name
  virtual_network_name = "scem-p-vnt-management-001"
  address_prefixes     = ["10.130.8.64/26"]
  providers = {
    azurerm = azurerm.management
  }
}

module "snet-bastion-eastus" {
  count                = local.select.location == "East US" ? 1 : 0
  source               = "../../modules/network/snet"
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.vnet-management["scem-b-vnt-management-001"].vnet_resource_group_name
  virtual_network_name = "scem-b-vnt-management-001"
  address_prefixes     = ["10.133.8.64/26"]
  providers = {
    azurerm = azurerm.management
  }
}

module "dpr_virtual_network_link-management" {
  source                    = "../../modules/network/dpr/vnetlink"
  for_each                  = { for k, v in local.select.dpr.dpr_virtual_network_link : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  name                      = each.key
  dns_forwarding_ruleset_id = each.value
  virtual_network_id        = module.vnet-management[each.key].out.id
  providers = {
    azurerm = azurerm.management
  }
}

module "conn-management" {
  for_each                  = { for peer in toset(local.select.hubpeers) : peer => peer if split("-", peer)[3] == "management" && local.select.env == "prod" }
  source                    = "../../modules/network/conn"
  name                      = "scem-${split("-", each.value)[1]}-vnc-connectivity-${split("-", each.value)[4]}-vnt${split("-", each.value)[3]}"
  virtual_hub_id            = local.select.vhub_id
  remote_virtual_network_id = module.vnet-management[each.value].out.id
  internet_security_enabled = false
  #depends_on = [module.vnet, module.vhub,]
  providers = {
    azurerm = azurerm.management
  }
}

module "az-nsg-management" {
  for_each            = { for k, v in local.select.nsg : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  source              = "../../modules/network/nsg"
  name                = each.key
  location            = local.select.location
  resource_group_name = each.value
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.management
  }
}


module "az-nsg-rule-management" {
  for_each                     = { for k, v in local.select.nsgrule : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
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
  resource_group_name          = module.az-nsg-management[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name  = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.management
  }
}

module "az-nsg-rule-management1" {
  for_each                    = { for k, v in local.select.nsgrule1 : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
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
  resource_group_name         = module.az-nsg-management[substr(each.key, 6, length(each.key))].nsg_resource_group_name
  network_security_group_name = substr(each.key, 6, length(each.key))
  #depends_on = [module.az-nsg]
  providers = {
    azurerm = azurerm.management
  }
}


module "link-Subnet-NSG-management" {
  #for_each = local.select.nsg-subnet-assoc
  for_each = { for k, v in local.select.nsg-subnet-assoc : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }

  source                    = "../../modules/network/nsgassoc"
  subnet_id                 = module.snet-management[each.value].out.id
  network_security_group_id = module.az-nsg-management[each.key].out.id
  #depends_on = [module.snet, module.az-nsg,]
  providers = {
    azurerm = azurerm.management
  }
}


module "az-rt-management" {
  for_each = { for k, v in local.select.route_table : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }

  source                        = "../../modules/network/rt"
  name                          = each.key
  resource_group_name           = each.value
  location                      = local.select.location
  bgp_route_propagation_enabled = true
  #depends_on = [module.snet]
  providers = {
    azurerm = azurerm.management
  }
}

module "az-rt-rule-management" {
  for_each               = { for k, v in local.select.udr : k => v if length(v) == 5 && split("-", v[1])[3] == "management" && local.select.env == "prod" }
  source                 = "../../modules/network/udr/extRt"
  name                   = each.value[0]
  resource_group_name    = module.az-rt-management[each.value[1]].rt_resource_group_name
  route_table_name       = each.value[1]
  address_prefix         = each.value[2]
  next_hop_type          = each.value[3]
  next_hop_in_ip_address = each.value[4]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.management
  }
}

module "az-rt-rule1-management" {
  for_each            = { for k, v in local.select.udr : k => v if length(v) == 4 && split("-", v[1])[3] == "management" && local.select.env == "prod" }
  source              = "../../modules/network/udr/intRt"
  name                = each.value[0]
  resource_group_name = module.az-rt-management[each.value[1]].rt_resource_group_name
  route_table_name    = each.value[1]
  address_prefix      = each.value[2]
  next_hop_type       = each.value[3]
  #depends_on = [module.az-rt]
  providers = {
    azurerm = azurerm.management
  }
}

module "rt_assoc-management" {
  for_each       = { for k, v in local.select.rt_assoc : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  source         = "../../modules/network/rtassoc"
  subnet_id      = module.snet-management[each.value].out.id
  route_table_id = module.az-rt-management[each.key].out.id
  #depends_on = [module.snet, module.az-rt,]
  providers = {
    azurerm = azurerm.management
  }
}


#==========================================================================================
#uncommon resources
#===========================================================================================

module "az-bastion" {
  source = "../../modules/network/bst/"
  #count = local.select.env == "prod" ? 1 : 0
  count               = local.select.location == "West US 3" && local.select.env == "prod" ? 1 : 0
  name                = local.select.bst.name
  location            = local.select.location
  resource_group_name = local.select.bst.resource_group_name
  scale_units         = local.select.bst.scale_units
  #subnet_id            = module.snet-bastion.out[0].id
  subnet_id            = "/subscriptions/1e12fbac-aa72-49aa-9723-996a90cc4b4a/resourceGroups/scem-p-rgp-management-001/providers/Microsoft.Network/virtualNetworks/scem-p-vnt-management-001/subnets/AzureBastionSubnet"
  public_ip_address_id = module.az-pip-management[local.select.bst.ip_name].out.id
  #depends_on = [module.snet,module.az-pip,]
  providers = {
    azurerm = azurerm.management
  }
}

module "az-bastion-eastus" {
  source = "../../modules/network/bst/"
  #count = local.select.env == "prod" ? 1 : 0
  count               = local.select.location == "East US" ? 1 : 0
  name                = local.select.bst.name
  location            = local.select.location
  resource_group_name = local.select.bst.resource_group_name
  scale_units         = local.select.bst.scale_units
  #subnet_id            = module.snet-bastion-eastus.out[0].id
  subnet_id            = "/subscriptions/1e12fbac-aa72-49aa-9723-996a90cc4b4a/resourceGroups/scem-b-rgp-management-001-eastus/providers/Microsoft.Network/virtualNetworks/scem-b-vnt-management-001/subnets/AzureBastionSubnet"
  public_ip_address_id = module.az-pip-management[local.select.bst.ip_name].out.id
  #depends_on = [module.snet,module.az-pip,]
  providers = {
    azurerm = azurerm.management
  }
}


module "az-pip-management" {
  for_each             = { for k, v in local.select.pips : k => v if split("-", k)[3] == "management" && local.select.env == "prod" }
  source               = "../../modules/network/pip"
  name                 = each.key
  location             = local.select.location
  resource_group_name  = each.value
  allocation_method    = "Static"
  sku                  = "Standard"
  ddos_protection_mode = "Disabled"
  #depends_on = [module.az-rg]
  providers = {
    azurerm = azurerm.management
  }
}