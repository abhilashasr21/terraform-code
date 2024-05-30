resource "azurerm_lb" "internal" {
  count               = length(var.lb)
  name                = var.lb[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb[count.index].sku

  dynamic "frontend_ip_configuration" {
    for_each = var.lb[count.index].frontend_ip_configuration
    content {
      name                          = frontend_ip_configuration.value.name
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = var.subnet_id
      zones                         = ["1","2","3"]
    }
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  count           = length(var.lb)
  loadbalancer_id = azurerm_lb.internal[count.index].id
  name            = var.lb[count.index].bepool_name
}
locals {
  lb_probes = flatten([
    for lb in var.lb : [
      for probe in lb.probes : {
        lb_index     = index(var.lb, lb)
        name         = probe.name
        port         = probe.port
        protocol     = probe.protocol
        request_path = probe.request_path
      }
    ]
  ])
  lb_rules = flatten([
    for lb in var.lb : [
      for rule in lb.rules : {
        lb_index                       = index(var.lb, lb)
        name                           = rule.name
        protocol                       = rule.protocol
        frontend_port                  = rule.frontend_port
        backend_port                   = rule.backend_port
        frontend_ip_configuration_name = rule.frontend_ip_configuration_name
        enable_floating_ip             = rule.enable_floating_ip
      }
    ]
  ])
}
 
resource "azurerm_lb_probe" "probe" {
  for_each        = { for idx, probe in local.lb_probes : idx => probe }
  loadbalancer_id = azurerm_lb.internal[each.value.lb_index].id
  name            = each.value.name
  port            = each.value.port
  protocol        = each.value.protocol
 
  /*dynamic "request_path" {
    for_each = each.value.protocol == "Http" || each.value.protocol == "Https" ? [1] : []
    content {
      request_path = each.value.request_path
    }
  }*/
  request_path = each.value.request_path
}
 
resource "azurerm_lb_rule" "rule" {
  for_each = { for idx, rule in local.lb_rules : idx => rule }
 
  loadbalancer_id                = azurerm_lb.internal[each.value.lb_index].id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool[each.value.lb_index].id]
  probe_id           = azurerm_lb_probe.probe[each.key].id
  enable_floating_ip = each.value.enable_floating_ip
}