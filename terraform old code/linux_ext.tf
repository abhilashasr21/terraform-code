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

resource "azurerm_virtual_machine_extension" "custom_script" {
  name                 = "PythonVersion"
  virtual_machine_id   = data.azurerm_virtual_machine.vm_ext.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  settings = <<SETTINGS
  {
    "fileUris": ["./scripts/python.sh"],
    "commandToExecute": "bash script.sh"
  }
  SETTINGS
}

resource "azurerm_virtual_machine_extension" "linux_vm_diagnostics" {
  /*for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "windowsserver"
  }
  name                 = "LinuxVMDiagnostics"
  virtual_machine_id   = data.azurerm_virtual_machine.vm_ext.id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "LinuxDiagnostic"
  type_handler_version = "4.0"

  settings = templatefile("./Diagnostic/diagnostics_linux.json", {
    resource_id          = data.azurerm_virtual_machine.vm_ext.id
    storage_account_name = var.storage_account_name
  })

  protected_settings = <<SETTINGS
  {    
    "storageAccountName": "${var.storage_account_name}"
  }
  SETTINGS
}
*/




