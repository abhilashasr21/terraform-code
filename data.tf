data "azurerm_virtual_machine" "u_vm" {
  name                = "az-linux-02"
  resource_group_name = var.rg_1["name"]
}

data "template_file" "disk_initializationdb" {
  template = file("./scripts/DiskInitialization-DB.sh")
  vars     = {}
}