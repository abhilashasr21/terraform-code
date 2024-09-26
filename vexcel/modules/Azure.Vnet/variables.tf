variable "vnet" {
  type = object({
    name = string
    rg_name = string
    address_space = list(string)
  })
}

variable "subnet" {
  type = map(object({
    name = string
    address_prefix = string
  }))
}

