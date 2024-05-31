data "azurerm_storage_account" "st_account" {
  name = var.storage_account_name
  resource_group_name = var.rg_name
}