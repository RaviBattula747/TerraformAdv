resource "azurerm_private_dns_resolver_virtual_network_link" "example" {
  name                      = var.name
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  virtual_network_id        = var.virtual_network_id
}