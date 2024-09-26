resource "azurerm_databricks_workspace" "databricks" {
  name                        = var.databricks_name
  resource_group_name         = data.azurerm_resource_group.rg.name
  location                    = data.azurerm_resource_group.rg.location
  sku                         = var.sku
  managed_resource_group_name = "${data.azurerm_resource_group.rg.name}-${var.databricks_name}"
  custom_parameters {
    storage_account_name = var.storage_account_name
  }
}

