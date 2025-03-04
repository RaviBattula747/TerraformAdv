variable "name" {
  description = "The name of the virtual network"
  type        = string
}


variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created"
  type        = string
}

variable "virtual_hub_id" {
  description = "virtual hub id"
  type        = string
}

variable "scale_units" {
  description = "number fo scale units"
  type        = number
}