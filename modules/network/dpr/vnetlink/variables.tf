variable "name" {
  description = "The name of the dns_forwarding_ruleset"
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "private_dns_resolver_id"
  type        = string
}

variable "virtual_network_id" {
  description = "virtual_network name should be given, terraform will fetch the ID automatically"
  type        = string
}