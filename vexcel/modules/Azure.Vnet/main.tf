data "azurerm_resource_group" "rg_name" {
  name = var.vnet.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet.name
  location = data.azurerm_resource_group.rg_name.location
  resource_group_name = data.azurerm_resource_group.rg_name.name
  address_space = var.vnet.address_space

  dynamic "subnet" {
    for_each = var.subnet
    content {
      name             = subnet.value.name
      address_prefixes = [subnet.value.address_prefix]
    }
  }
}
