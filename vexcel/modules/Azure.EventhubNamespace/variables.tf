
variable "rg_name" {
  type = string
}

variable "name" {
  type = string
}

variable "sku" {
  type = string
}

variable "capacity" {
  type = number
}

variable "minimum_tls_version" {
  type = string
}

variable "public_network_access_enabled" {
  type = bool
}

variable "registry" {
  type = map(object({
    name = string
  }))
  default = {}
}
