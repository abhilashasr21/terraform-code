/*resource "azurerm_virtual_machine_extension" "linux_extension" {
  name                 = "DiskInitializationLinux"
  virtual_machine_id   = data.azurerm_virtual_machine.vm_ext.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    "commandToExecute" = data.template_file.disk_initializationdb.template
  })

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_machine_extension" "linux_diag" {
  name                  = "DiagnosticsIaasLinux"
  virtual_machine_id    = data.azurerm_virtual_machine.vm_ext.id
  publisher             = "Microsoft.Azure.Extensions"
  type                  = "CustomScript"
  type_handler_version  = "1.0"

  settings = jsondecode({
    "commandToExecute" = data.template_file.linux_diag_json.template
  }) 
}*/

