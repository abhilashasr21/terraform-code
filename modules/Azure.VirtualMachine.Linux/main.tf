resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.pip_allocation
  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  name = var.nic_name
  location = var.location
  resource_group_name = var.rg_name

  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name = ip_configuration.value.name
      subnet_id = var.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address = ip_configuration.value.private_ip_address
      public_ip_address_id = azurerm_public_ip.pip.id
    }
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "name" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false
  bypass_platform_safety_checks_on_user_schedule_enabled = true
  patch_assessment_mode = "AutomaticByPlatform"
  patch_mode = "AutomaticByPlatform"
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  os_disk {
    name = var.os_disk_name
    caching = var.caching
    storage_account_type = var.storage_type
  }
  source_image_reference {
    publisher = var.image_reference["publisher"]
    offer     = var.image_reference["offer"]
    sku       = var.image_reference["sku"]
    version   = var.image_reference["version"]
  }
  boot_diagnostics {
    storage_account_uri = data.azurerm_storage_account.st_account.primary_blob_endpoint
  }
  tags = var.tags
}

resource "azurerm_managed_disk" "disk" {
  name                 = "${var.name}-datadisk1"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "name" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.name.id
  lun                = "1"
  caching            = "ReadWrite"
}