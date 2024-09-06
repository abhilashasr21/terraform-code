resource "azurerm_storage_account" "example" {
  name                            = var.name
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = false
  account_kind                    = "FileStorage"
}

#####################################################################################
#                                 Fileshare creation                                #
#####################################################################################

/*resource "azurerm_storage_share" "fileshare" {
  count                = length(var.fileshare_list) > 0 ? length(var.fileshare_list) : 0
  storage_account_name = var.name
  name                 = var.fileshare_list[count.index].name
  access_tier          = var.fileshare_list[count.index].access_tier
  enabled_protocol     = var.fileshare_list[count.index].enabled_protocol
  quota                = var.fileshare_list[count.index].quota
}*/


resource "azurerm_storage_share" "example" {
  for_each             = var.fileshare_list
  name                 = each.value.name
  storage_account_name = each.value.storage_account_name
  quota                = each.value.quota # Optional, specify quota in GB
  access_tier          = each.value.access_tier
  enabled_protocol     = each.value.enabled_protocol
}