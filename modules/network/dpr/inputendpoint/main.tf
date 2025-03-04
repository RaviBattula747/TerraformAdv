
resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound_endpoint" {
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.subnet_id
  }
      lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
