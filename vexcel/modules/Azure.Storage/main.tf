resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.replication
}

resource "azurerm_storage_encryption_scope" "scope" {
  count              = var.encryption_scope == true ? 1 : 0
  name               = "${var.sa_name}-encrypted"
  storage_account_id = azurerm_storage_account.sa.id
  source             = "Microsoft.Storage"
  //infrastructure_encryption_required = each.value.enable_infrastructure_encryption
}