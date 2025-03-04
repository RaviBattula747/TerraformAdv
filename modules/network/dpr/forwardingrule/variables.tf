variable "name" {
  description = "The name of the dns_forwarding_ruleset"
  type        = string
}

variable "domain_name" {
  description = "domain_name"
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "dns_forwarding_ruleset name has to be given, so written code directly fetch its ID"
  type        = string
}