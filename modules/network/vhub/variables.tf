variable "name" {
  description = "The name of the virtual hub"
  type        = string
}


variable "location" {
  description = "The location of the vhub"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for vhub"
  type        = string
}

variable "virtual_wan_id" {
  description = "address space for vhub"
  type        = string
}

variable "address_prefix" {
  description = "address space for vhub"
  type        = string
}