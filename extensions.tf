#####################################################################################
#                           Install VM Extension                                    #
#####################################################################################
 
/*resource "azurerm_virtual_machine_extension" "install_customscriptextensiondb" {
 /* for_each = {
    for k, v in var.vm_list : k => v
    if v.vm_category == "database"
  }
  name                 = "CustomScriptExtension-DiskInitializationdb"
  //virtual_machine_id   = azurerm_virtual_machine.windows_vm[each.key].id
  virtual_machine_id = "/subscriptions/f4a270f4-c469-4215-bef6-b4abaea6815e/resourceGroups/az-rg-01/providers/Microsoft.Compute/virtualMachines/az-test-02"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
 
  /*protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.disk_initializationdb.rendered)}')) | Out-File -filepath DiskInitialization-DB.ps1\" && powershell -ExecutionPolicy Unrestricted -File DiskInitialization-DB.ps1"
  }
  SETTINGS
 
  depends_on = [
    azurerm_virtual_machine_data_disk_attachment.data_disk_attachment
  ]
}*/
 
/*data "template_file" "disk_initializationdb" {
  template = file("../scripts/DiskInitialization-DB.ps1")
  vars     = {}
}*/
#####################################################################################
#                           Install VM Extension for Diagnostics                    #
#####################################################################################
 
/*resource "azurerm_virtual_machine_extension" "windows_vm_diagnostics" {
  for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "windowsserver"
  }
  name                 = "WindowsVMDiagnostics"
 // virtual_machine_id   = azurerm_virtual_machine.windows_vm[each.key].id
 virtual_machine_id = ""
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "IaaSDiagnostics"
  type_handler_version = "1.22"
 
  settings = templatefile("../../../monitoring/windows-vm-extension-iaasdiagnostics-config/diagnostics.json", {
    //resource_id          = azurerm_virtual_machine.windows_vm[each.key].id
    resource id = ""
    //storage_account_name = var.vm_list[each.key].vm_diagnostics_storage_account_name
    storage_account_name = ""
  })
 
 /* protected_settings = <<SETTINGS
  {    
    "storageAccountName": "${var.vm_list[each.key].vm_diagnostics_storage_account_name}"
  }
  SETTINGS
}*/