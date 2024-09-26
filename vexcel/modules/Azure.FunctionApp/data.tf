data "azurerm_resource_group" "rg_name" {
  name = var.rg_name
}

data "azurerm_storage_account" "st_account" {
  name                = var.st_account
  resource_group_name = data.azurerm_resource_group.rg_name.name
}

