resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound_endpoint" {
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location
  subnet_id               = var.subnet_id
    lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
