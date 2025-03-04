variable "name" {
  description = "The name of the route_table"
  type        = string
}


variable "location" {
  description = "The location of the route table"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created"
  type        = string
}

variable "bgp_route_propagation_enabled" {
  description = "true or false"
  type        = bool
}