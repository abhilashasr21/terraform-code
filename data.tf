/*data "template_file" "disk_initializationdb" {
  template = file("./scripts/DiskInitialization-DB.sh")
  vars     = {}
}

data "template_file" "linux_diag_json" {
  template = file("./diagnostic/diagnostics.json")
  vars = {}
}

data "azurerm_virtual_machine" "vm_ext" {
  name                = var.linux_vm_01["name"]
  resource_group_name = var.rg_1["name"]
}*/