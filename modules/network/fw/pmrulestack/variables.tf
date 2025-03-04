variable "name" {
  description = "The name of the rulestack to hub"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name of the rule stack"
  type        = string
}

variable "panorama_base64_config" {
  description = "The resource id of rulestack"
  type        = string
}

variable "location" {
  description = "The location of rulestack"
  type        = string
}

variable "public_ip_address_ids" {
  description = "The public ip address for the firewall"
  type        = list(string)
}

variable "trusted_address_ranges" {
  description = "The trusted_address_ranges for the firewall"
  type        = list(string)
}

variable "virtual_hub_id" {
  description = "The resource id of virtual hub"
  type        = string
}

variable "network_virtual_appliance_id" {
  description = "The resource id of network virtual appliance"
  type        = string
}