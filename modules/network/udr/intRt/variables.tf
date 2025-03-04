variable "name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_prefix" {
  description = "The address space of the virtual network"
  type        = string
}

variable "route_table_name" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group of the  Routetable will be created"
  type        = string
}

variable "next_hop_type" {
  description = "Type of next hop"
  type        = string
}