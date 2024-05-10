resource "azurerm_virtual_machine_extension" "linux_extension" {
  name                 = "CustomScriptExtensionLinuxk"
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

data "template_file" "disk_initializationdb" {
  template = file("./scripts/DiskInitialization-DB.sh")
  vars     = {}
}

data "azurerm_virtual_machine" "vm_ext" {
  name                = var.linux_vm_01["name"]
  resource_group_name = var.rg_1["name"]
}