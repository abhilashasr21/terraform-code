resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "eventhub-private-endpoint"
  resource_group_name = data.azurerm_resource_group.rg_name.name
  location            = data.azurerm_resource_group.rg_name.location
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "eventhub-private-connection"
    private_connection_resource_id = azurerm_eventhub_namespace.namespace.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }
}

resource "azurerm_private_dns_a_record" "dns_a_record" {
  name                = "myeventhubnamespace"
  zone_name           = azurerm_private_dns_zone.private_dnszone.name
  resource_group_name = data.azurerm_resource_group.rg_name.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pe-eventhub.private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone" "private_dnszone" {
  name                = "Private-DNS-Zone"
  resource_group_name = data.azurerm_subnet.subnet.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "eventhub-privatedns-link"
  resource_group_name   = data.azurerm_subnet.subnet.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dnszone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}