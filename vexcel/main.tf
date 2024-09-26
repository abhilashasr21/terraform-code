resource "azurerm_resource_group" "vexcel-test" {
  name     = var.rg.name
  location = var.rg.location
}

####################################################################
#                             Network                              #
####################################################################

module "vnet" {
  source = "./modules/Azure.Vnet"
  vnet   = var.vnet
  subnet = var.subnet
  depends_on = [
    azurerm_resource_group.vexcel-test
  ]
}
####################################################################
#                        Storage Account                           #
####################################################################
/*
module "sa-01" {
  source       = "./modules/Azure.Storage"
  sa_name      = var.sa-01.name
  account_tier = var.sa-01.account_tier
  replication  = var.sa-01.replication
  rg_name      = var.rg.name
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls" {
  name               = "vexcel-datalake-fs"
  storage_account_id = data.azurerm_storage_account.sa-01.id
  depends_on = [
    module.sa-01
  ]
}

resource "azurerm_storage_container" "sa-01-container" {
  for_each              = var.container
  name                  = each.value.name
  storage_account_name  = var.sa-01.name
  container_access_type = each.value.container_access_type
  depends_on = [
    module.sa-01
  ]
}


####################################################################
#                           Event Hub                              #
####################################################################

module "eventhub_namespace" {
  source                        = "./modules/Azure.EventhubNamespace"
  rg_name                       = var.rg.name
  name                          = var.eventhub_namespace.name
  sku                           = var.eventhub_namespace.sku
  minimum_tls_version           = var.eventhub_namespace.minimum_tls_version
  capacity                      = var.eventhub_namespace.capacity
  public_network_access_enabled = var.eventhub_namespace.public_network_access_enabled
  registry                      = var.namespace_registry
}

module "eventhub" {
  for_each           = var.eventhub
  source             = "./modules/Azure.EventHub"
  name               = each.value.name
  rg_name            = var.rg.name
  eventhub_namespace = var.eventhub_namespace.name
  message_retention  = each.value.message_retention
  partition_count    = each.value.partition_count
  consumer_group     = each.value.consumer_group
  depends_on = [
    module.eventhub_namespace
  ]
}

####################################################################
#                           Funtion App                            #
####################################################################

module "fa-vexcel" {
  source            = "./modules/Azure.FunctionApp"
  function_app_name = "vexcel-poc-01"
  app_service_plan  = "vexcel-app-service"
  rg_name           = var.rg.name
  st_account        = var.sa-01.name
}


resource "azurerm_app_service_connection" "connector" {
  name               = "fa_eh_serviceconnector_01"
  app_service_id     = module.fa-vexcel.function_app_id
  target_resource_id = module.eventhub_namespace.eventhub_namespace_id
  client_type        = "dotnet"
  authentication {
    type = "systemAssignedIdentity"
  }
  depends_on = [
    module.fa-vexcel,
    module.eventhub
  ]
}
####################################################################
#                           KeyVault                               #
####################################################################

module "KeyVault" {
  source        = "./modules/Azure.Keyvault"
  rg_name       = var.rg.name
  keyvault_name = "vexcel-poc-keyvault"
}

####################################################################
#                          DataBricks                              #
####################################################################

module "vexcel-databricks" {
  source               = "./modules/Azure.Databricks"
  rg_name              = var.rg.name
  sku                  = "trial"
  databricks_name      = "vexcel-databricks-01"
  storage_account_name = "sadatabrickswestus01"
}*/