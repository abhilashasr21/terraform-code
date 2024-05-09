resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name  

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = nsg_rules.value.name
      priority                   = nsg_rules.value.priority
      direction                  = nsg_rules.value.direction
      access                     = nsg_rules.value.access
      protocol                   = nsg_rules.value.protocol
      source_port_range          = nsg_rules.value.source_port_range
      destination_port_range     = nsg_rules.value.destination_port_range
      source_address_prefix      = nsg_rules.value.source_address_prefix
      destination_address_prefix = nsg_rules.value.destination_address_prefix
    }
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}