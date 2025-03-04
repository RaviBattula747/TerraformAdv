variable "name" {
  description = "The name of the virtual wan"
  type        = string
}


variable "location" {
  description = "The location of the vwan"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for vwan"
  type        = string
}

variable "type" {
  description = "type of vwan"
  type        = string
}