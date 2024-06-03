variable "name" {
  type = string
  description = "NSG NAme"
}

variable "subnet_id" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "tags" {
  type = map(string)
}