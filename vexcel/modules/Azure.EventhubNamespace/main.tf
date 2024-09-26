resource "azurerm_eventhub_namespace" "namespace" {
  name                = var.name
  location            = data.azurerm_resource_group.rg_name.location
  resource_group_name = data.azurerm_resource_group.rg_name.name
  sku                 = var.sku
  capacity            = var.capacity
  minimum_tls_version = var.minimum_tls_version
  //local_authentication_enabled  = true
  public_network_access_enabled = var.public_network_access_enabled
}

resource "azurerm_eventhub_namespace_schema_group" "schema_registey" {
  for_each             = var.registry != null ? var.registry : {}
  name                 = each.value.registry
  namespace_id         = azurerm_eventhub_namespace.namespace.id
  schema_type          = "Avro"
  schema_compatibility = "Backward"
}


/*
resource "azurerm_stream_analytics_job" "sa-job" {
  name                                     = "eventhub-sa-job"
  resource_group_name                      = data.azurerm_resource_group.rg_name.name
  location                                 = data.azurerm_resource_group.rg_name.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3
  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY

identity {
  type = "SystemAssigned"
}

}

/*
resource "azurerm_stream_analytics_output_eventhub" "eventhub-sa-output" {
  name                      = "output-to-eventhub"
  stream_analytics_job_name = azurerm_stream_analytics_job.sa-job.name
  resource_group_name       = azurerm_stream_analytics_job.sa-job.resource_group_name
  eventhub_name             = azurerm_eventhub.hub.name
  servicebus_namespace      = azurerm_eventhub_namespace.namespace.name
  shared_access_policy_key  = azurerm_eventhub_namespace.namespace.default_primary_key
  shared_access_policy_name = "RootManageSharedAccessKey"

  serialization {
    type = "Json"
    encoding = "UTF8"
  }

  depends_on = [ 
    azurerm_stream_analytics_job.sa-job,
    azurerm_eventhub.hub,
    azurerm_eventhub_namespace.namespace
   ]
}

}*/

