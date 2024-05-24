/*resource "azurerm_virtual_machine_extension" "linux_vm_diagnostics" {
  for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "linuxserver"
  }
  name                 = "LinuxDiagnostic"
  virtual_machine_id   = module.linux_vm_01.id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "LinuxDiagnostic"
  type_handler_version = "3.0"

  settings = templatefile("./Diagnostic/diagnostics_linux.json", {
    resource_id          = module.linux_vm_01.id
    storage_account_name = var.storage_account_name
  })

  protected_settings = <<SETTINGS
  {    
    "storageAccountName": "${var.storage_account_name}"
  }
  SETTINGS
}

resource "azurerm_virtual_machine_extension" "linux_vm_diagnostics" {
  name                 = "LinuxDiagnosticTest"
  virtual_machine_id   = module.linux_vm_02.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = templatefile("./Diagnostic/diagnostics_linux.json", {
    resource_id          = module.linux_vm_02.id
    storage_account_name = var.storage_account_name
  })

  protected_settings = <<SETTINGS
  {    
    "storageAccountName": "${var.storage_account_name}"
  }
  SETTINGS


  tags = var.tags
}*/