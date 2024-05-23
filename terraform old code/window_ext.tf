#####################################################################################
#                           Install VM Extension for Diagnostics                    #
#####################################################################################
/*resource "azurerm_virtual_machine_extension" "windows_vm_diagnostics" {
  for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "windowsserver"
  }
  name                 = "WindowsVMDiagnostics"
  virtual_machine_id   = data.azurerm_virtual_machine.vm_ext_w.id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "IaaSDiagnostics"
  type_handler_version = "1.22"

  settings = templatefile("./Diagnostic/diagnostics_windows.json", {
    resource_id          = data.azurerm_virtual_machine.vm_ext_w.id
    storage_account_name = var.storage_account_name
  })

  protected_settings = <<SETTINGS
  {    
    "storageAccountName": "${var.storage_account_name}"
  }
  SETTINGS
}
*/