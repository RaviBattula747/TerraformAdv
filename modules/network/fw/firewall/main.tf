resource "azurerm_palo_alto_virtual_network_appliance" "nva" {
  name           = var.name
  virtual_hub_id = var.virtual_hub_id
  /*lifecycle {
    ignore_changes = [tags]
  }*/
}