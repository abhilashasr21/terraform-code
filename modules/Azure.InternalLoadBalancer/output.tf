output "lb_ids" {
  value = azurerm_lb.internal[*].id
}

output "bepool" {
  value = azurerm_lb_backend_address_pool.bepool[*].id
}