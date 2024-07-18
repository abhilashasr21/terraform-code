variable "backend_http_settings" {
  type = map(object({
    name     = string
    port     = string
    protocol = string
  }))
  default = {
    "backend_http_settings_1" = {
      name     = "example-network-be-htst"
      port     = "80"
      protocol = "Http"
    }
    "backend_http_settings_2" = {
      name     = "example-network-be-htst-2"
      port     = "443"
      protocol = "Https"
    }
  }
}