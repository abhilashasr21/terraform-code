variable "name" {
  type = string
  description = "NSG NAme"
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "nsg_rules" {
  type = map(object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = list(string)
    destination_port_range = list(string)
    source_address_prefix = string
    destination_address_prefix = string
  }))
}

variable "tags" {
  type = map(string)
}