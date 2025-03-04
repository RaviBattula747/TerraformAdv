resource "azurerm_bastion_host" "az-bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_connect_enabled  = true
  scale_units         = var.scale_units
  sku                 = "Standard"
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
  lifecycle {
    ignore_changes = [tunneling_enabled, tags]
        }
}