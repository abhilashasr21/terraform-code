/*locals {
  settings_content = jsondecode(file("portal_public_settings.json"))
  updated_settings = merge(local.settings_content, {
    storage_account_name = "linuxstacc01"
    resource_id          = data.azurerm_virtual_machine.rhel_vm.id
  })
  sas_token = "se=2037-12-31T23%3A59%3A00Z&sp=wlacu&sv=2022-11-02&ss=tb&srt=co&sig=A2XNcDbh6E0hoMUtlDmh5UNst1U4czIqJ%2B6LauYa9yQ%3D"
}

data "azurerm_virtual_machine" "u_vm" {
  name                = "azlinux02"
  resource_group_name = var.rg_1["name"]
}

data "azurerm_virtual_machine" "rhel_vm" {
  name                = "az-linux-01"
  resource_group_name = var.rg_1["name"]
}

data "template_file" "disk_initializationdb" {
  template = file("./scripts/DiskInitialization-DB.sh")
  vars     = {}
}

data "template_file" "python_installation" {
  template = file("./scripts/python_rhel.sh")
  vars = {}
}

resource "azurerm_virtual_machine_extension" "linux_extension" {
  name                 = "DiskInitializationLinux"
  virtual_machine_id   = data.azurerm_virtual_machine.rhel_vm.id
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

resource "azurerm_virtual_machine_extension" "python_extension" {
  name                 = "Python_Initialization"
  virtual_machine_id   = data.azurerm_virtual_machine.rhel_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode({
    "commandToExecute" = data.template_file.python_installation.template
  })

  tags = {
    environment = "Production"
  }
}


resource "azurerm_virtual_machine_extension" "linux_vm_diagnostics" {
  for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "linuxserver"
  }
  name                       = "LinuxDiagnostic"
  virtual_machine_id         = data.azurerm_virtual_machine.rhel_vm.id
  auto_upgrade_minor_version = true
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "LinuxDiagnostic"
  type_handler_version       = "3.0"
  settings                   =jsonencode(local.settings_content)
  protected_settings         =jsonencode({
    storageAccountName : "linuxstacc01",
    storageAccountSasToken : "se=2037-12-31T23%3A59%3A00Z&sp=wlacu&sv=2022-11-02&ss=tb&srt=co&sig=A2XNcDbh6E0hoMUtlDmh5UNst1U4czIqJ%2B6LauYa9yQ%3D"
  }) 
  //tags               = var.tags
}


/*resource "azurerm_virtual_machine_extension" "OmsAgentForLinux" {
  /*for_each = {
    for k, v in var.vm_list : k => v
    if lower(v.image_offer) == "linuxserver"
  }
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
}*/
