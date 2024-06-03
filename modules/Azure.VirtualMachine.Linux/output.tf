output "id" {
  value = azurerm_linux_virtual_machine.name.id
}

output "pip" {
  value = azurerm_public_ip.pip.id
}