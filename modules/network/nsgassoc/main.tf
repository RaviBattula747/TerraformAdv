resource "azurerm_subnet_network_security_group_association" "link-Subnet-NSG" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id
}
