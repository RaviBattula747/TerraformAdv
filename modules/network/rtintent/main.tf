resource "azurerm_virtual_hub_routing_intent" "az-rtintent" {

  name           = "rtintent"
  virtual_hub_id = var.virtual_hub_id

  routing_policy {
    name         = "InternetTrafficPolicy"
    destinations = ["Internet"]
    next_hop     = var.next_hop
  }
     routing_policy {
    name         = "PrivateTrafficPolicy"
    destinations = ["PrivateTraffic"]
    next_hop     = var.next_hop
  }
}