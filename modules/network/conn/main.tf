resource "azurerm_virtual_hub_connection" "peer" {

  name                      = var.name
  virtual_hub_id            = var.virtual_hub_id
  remote_virtual_network_id = var.remote_virtual_network_id
  internet_security_enabled = var.internet_security_enabled#split("/", var.remote_virtual_network_id)[8] == "scem-p-vnt-management-001" ?  false : true
}