resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  
  dynamic "subnet" {
    for_each = var.subnet
    content {
      name             = subnet.value.name
      address_prefix   = subnet.value.address_prefix
    }
  }

  tags                = var.tags
}