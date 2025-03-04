
resource "azurerm_palo_alto_next_generation_firewall_virtual_hub_panorama" "pafwpm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  network_profile {
    public_ip_address_ids        = var.public_ip_address_ids
    virtual_hub_id               = var.virtual_hub_id
    network_virtual_appliance_id = var.network_virtual_appliance_id
    trusted_address_ranges       = var.trusted_address_ranges
  }

  dns_settings {
    dns_servers = var.location == "East US" ? ["10.133.10.68"] : ["10.130.10.68"] #- (Optional) Specifies a list of DNS servers to proxy. Conflicts with dns_settings[0].use_azure_dns.
    use_azure_dns = null # - (Optional) Should Azure DNS servers be used? Conflicts with dns_settings[0].dns_servers. Defaults to false.
  } 
  panorama_base64_config = var.panorama_base64_config
  lifecycle {
    ignore_changes = [tags]
  }
}