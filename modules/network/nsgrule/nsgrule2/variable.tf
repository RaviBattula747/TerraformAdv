variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource_group_name"
  type        = string
}

variable "priority" {
  description = "The name of the priority"
  type        = number
}

variable "source_port_range" {
  description = "The name of the resource_group_name"
  type        = string
  default = "*"
}

variable "direction" {
  description = "The name of the direction"
  type        = string
}

variable "access" {
  description = "The name of the access"
  type        = string
}

variable "protocol" {
  description = "The name of the protocol"
  type        = string
}

variable "destination_port_ranges" {
  description = "The name of the destination_port_ranges"
  type        = list(string)
}

variable "source_address_prefix" {
  description = "source IPs list"
  type        = string
}

variable "destination_address_prefix" {
  description = "The destination address prefixes"
  type        = string
}


variable "network_security_group_name" {
  description = "The name of the network_security_group"
  type        = string
}

