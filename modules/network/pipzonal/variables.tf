variable "name" {
  description = "The name of the public IP address"
  type        = string
}

variable "location" {
  description = "The location of the public IP address"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the public IP address"
  type        = string
}

variable "zones" {
  description = "The number of the zones"
  type        = list(string)
}

variable "allocation_method" {
  description = "allocation_methodnnstatic or dynamic"
  type        = string
}

variable "sku" {
  description = "sku must be standard because basic is going to be retired"
  type        = string
  default     = "standard"
}

variable "ddos_protection_mode" {
  description = "ddos_protection_mode"
  type        = string
}