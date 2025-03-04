variable "name" {
  description = "The name of the bastion host"
  type        = string
}


variable "location" {
  description = "The location of the bastion host"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the bastion host"
  type        = string
}

variable "subnet_id" {
  description = "The address space of the bastion host"
  type        = string
}

variable "public_ip_address_id" {
  description = "The address space of the bastion host"
  type        = string
}

variable "scale_units" {
  description = "defauilts to 2 scale units, max is 50"
  type        = number
}