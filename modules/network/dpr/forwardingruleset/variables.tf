variable "name" {
  description = "The name of the dns_forwarding_ruleset"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "private_dns_resolver_outbound_endpoint_ids" {
  description = "private_dns_resolver_outbound_endpoint_ids"
  type        = list(string)
}