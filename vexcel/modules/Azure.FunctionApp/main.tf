resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan
  location            = data.azurerm_resource_group.rg_name.location
  resource_group_name = data.azurerm_resource_group.rg_name.name
  os_type             = "Windows"
  sku_name            = "Y1"
}


resource "azurerm_windows_function_app" "name" {
  name                       = var.function_app_name
  resource_group_name        = data.azurerm_resource_group.rg_name.name
  location                   = data.azurerm_resource_group.rg_name.location
  storage_account_name       = data.azurerm_storage_account.st_account.name
  storage_account_access_key = data.azurerm_storage_account.st_account.primary_access_key
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  site_config {
    application_stack {
      dotnet_version              = "v8.0"
      use_dotnet_isolated_runtime = true
    }
    use_32_bit_worker = false
  }
  identity {
    type = "SystemAssigned"
  }
  storage_account {
    access_key   = data.azurerm_storage_account.st_account.primary_access_key
    account_name = data.azurerm_storage_account.st_account.name
    name         = "${var.function_app_name}-storage"
    share_name   = "test-datalake-fs"
    type         = "AzureFiles"
  }
}
/*
resource "azurerm_function_app_connection" "azurerm_function_app_connection" {
  name               = "fa_eventhub_conn_01"
  function_app_id    = azurerm_windows_function_app.name.id
  //target_resource_id = data.azurerm_eventhub.eventhub.id
  target_resource_id = "/subscriptions/5a395407-07f8-47a9-b8bf-92c05227486c/resourceGroups/Test-Vexcel/providers/Microsoft.ServiceBus/namespaces/vexcel-poc/eventhubs/vexcel-hub-01"
  client_type        = "dotnet"
  authentication {
    type = "systemAssignedIdentity"
  }
}*/



