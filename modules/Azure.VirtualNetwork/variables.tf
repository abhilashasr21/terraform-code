variable "name" {
  type = string
}

variable "location" {
  type = string
  default = "eastus2"
}

variable "address_space" {
  type = list(string)
}

variable "rg_name" {
  type = string
}

variable "subnet" {
  type = map(object({
    name = string
    address_prefix = string
  }))
  description = "list of subnets"
}

variable "tags" {
  type = map(string)
  default = {
    Deployment = "terraform"
    Environment = "Test"
  }
}