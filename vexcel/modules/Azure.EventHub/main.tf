resource "azurerm_eventhub" "hub" {
  //for_each            = var.eventhub
  name                = var.name
  namespace_name      = data.azurerm_eventhub_namespace.namespace.name
  resource_group_name = data.azurerm_resource_group.rg_name.name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}

resource "azurerm_eventhub_consumer_group" "consumer_group" {
  for_each            = var.consumer_group != null ? var.consumer_group : {}
  name                = each.value.name
  namespace_name      = data.azurerm_eventhub_namespace.namespace.name
  eventhub_name       = azurerm_eventhub.hub.name
  resource_group_name = data.azurerm_resource_group.rg_name.name
}



#########################################################
#                  For Avro Capture                     #
#########################################################
/*

resource "azurerm_eventhub" "hub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  resource_group_name = data.azurerm_resource_group.rg_name.name
  partition_count     = 1
  message_retention   = 1

  capture_description {
    enabled             = true
    encoding            = "Avro"
    interval_in_seconds = 300
    size_limit_in_bytes = 10485760
    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
      blob_container_name = "vexceleventhub01"
      storage_account_id  = data.azurerm_storage_account.sa.id
    }
  }*/