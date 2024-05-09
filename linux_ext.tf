resource "azurerm_virtual_machine_extension" "linux_extension" {
  name                 = "CustomScriptExtensionLinuxk"
  virtual_machine_id   = "/subscriptions/f4a270f4-c469-4215-bef6-b4abaea6815e/resourceGroups/az-rg-01/providers/Microsoft.Compute/virtualMachines/az-test-01"
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