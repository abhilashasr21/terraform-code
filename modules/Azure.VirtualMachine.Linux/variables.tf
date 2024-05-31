variable "nic_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "ip_configuration" {
  type = map(object({
    name = string
    //subnet_id = string
    private_ip_address_allocation = string
    private_ip_address = string
  }))
}
variable "subnet_id" {
  type = string
}
variable "name" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "os_disk_name" {
  type = string
}

variable "caching" {
  type = string
  default = "None"
}

variable "storage_type" {
  type = string
  default = "Standard_LRS"
}

variable "image_reference" {
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
}

variable "tags" {
  type = map(string)
  default = {
    Deployment = "terraform"
    Environment = "Test"
  }
}

variable "storage_account_name" {
  type = string
}