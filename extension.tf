resource "azurerm_virtual_machine_extension" "OmsAgentForLinux" {
  name                       = "OmsAgentForLinux"
  virtual_machine_id         = data.azurerm_virtual_machine.u_vm.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  settings = jsonencode(
    {
      workspaceId = "5692b0e3-234c-4819-be02-f4dea1bacca1"
    }
  )
}

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
*/
locals {
  settings_content = jsondecode(file("./Diagnostic/diag.json"))
  updated_settings = merge(local.settings_content, {
    storage_account_name = var.storage_account_name
    resource_id          = data.azurerm_virtual_machine.u_vm.id
  })
}
resource "azurerm_virtual_machine_extension" "linux_vm_diagnostics" {
  name                       = "LinuxDiagnostic"
  virtual_machine_id         = data.azurerm_virtual_machine.u_vm.id
  auto_upgrade_minor_version = true
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "LinuxDiagnostic"
  type_handler_version       = "3.0"
  settings                   = jsonencode(local.settings_content)
  //tags               = var.tags
}


resource "azurerm_virtual_machine_extension" "linux_extension" {
  name                 = "DiskInitializationLinux"
  virtual_machine_id   = data.azurerm_virtual_machine.u_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    "commandToExecute" = data.template_file.disk_initializationdb.template
  })

  protected_settings = jsonencode({
    storage_account_name = var.storage_account_name
  })

  tags = {
    environment = "Production"
  }
}