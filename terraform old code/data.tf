data "template_file" "disk_initializationdb" {
  template = file("./scripts/DiskInitialization-DB.sh")
  vars     = {}
}
/*
data "template_file" "linux_diag_json" {
  template = file("./diagnostic/diagnostics_linux.json")
  vars = {
    storage_account_name = var.storage_account_name
    //resource_id = data.azurerm_virtual_machine.vm_ext.id
  }
}

data "template_file" "windows_diag_json" {
  template = file("./diagnostic/diagnostics.json")
  vars = {
    storage_account_name = var.storage_account_name
    resource_id = data.azurerm_virtual_machine.vm_ext.id
  }
}*/

data "azurerm_virtual_machine" "vm_ext" {
  name                = "az-linux-02"
  resource_group_name = var.rg_1["name"]
}

data "azurerm_virtual_machine" "vm_ext_w" {
  name                = "az-windows-01"
  resource_group_name = var.rg_1["name"]
}
