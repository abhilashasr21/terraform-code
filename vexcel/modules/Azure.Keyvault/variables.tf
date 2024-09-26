variable "rg_name" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "sku_name" {
  type = string
  default = "standard"
}

variable "enabled_for_deployment" {
  type = bool
  default = true
}