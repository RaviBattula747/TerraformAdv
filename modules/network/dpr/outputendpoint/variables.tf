variable "name" {
  description = "The name of the dns_forwarding_ruleset"
  type        = string
}

variable "private_dns_resolver_id" {
  description = "private_dns_resolver_id"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "subnet_id" {
  description = "subnet name should be given and the terraform would automatically fetch that id"
  type        = string
}