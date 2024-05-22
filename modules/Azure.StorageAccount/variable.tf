variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "account_tier" {
  type = string
  default = "Standard"
}

variable "account_replication_type" {
  type = string
  default = "LRS"
}