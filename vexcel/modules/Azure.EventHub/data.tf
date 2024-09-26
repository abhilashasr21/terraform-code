data "azurerm_resource_group" "rg_name" {
  name = var.rg_name
}

data "azurerm_eventhub_namespace" "namespace" {
  name = var.eventhub_namespace
  resource_group_name = var.rg_name
}