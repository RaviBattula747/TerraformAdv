resource "azurerm_private_dns_resolver_forwarding_rule" "forwardingrule" {
  name                      = var.name
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  domain_name               = var.domain_name
  enabled                   = true
  target_dns_servers {
    ip_address =  var.domain_name != "." ? "172.28.128.15" : "208.67.220.220"
    port       = 53
  }
    target_dns_servers {
    ip_address =  var.domain_name != "." ? "163.236.98.160" : "208.67.222.222"
    port       = 53
  }
}