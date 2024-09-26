resource "azurerm_key_vault" "vexcel-poc-kv" {
  name                        = var.keyvault_name
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  //soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_deployment
  sku_name = var.sku_name
  network_acls {
    bypass = "AzureServices"
    default_action = "Allow"
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}