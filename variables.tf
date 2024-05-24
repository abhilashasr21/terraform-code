##############################################
#               Subscription                 #
##############################################

variable "subscription_id" {
  type        = string
  description = "This is the Tenant Subscription ID"
}

##############################################
#              Resource Groups               #
##############################################
variable "rg_1" {
  type = object({
    name     = string
    location = string
  })

}

variable "tags" {
  type = map(string)
}
##############################################
#              VNet and Subnet               #
##############################################
variable "vnet_1" {
  type = object({
    name          = string
    address_space = list(string)
  })
}
variable "subnets" {
  type = map(object({
    name           = string
    address_prefix = string
  }))
}

##############################################
#                    NSG                     #
##############################################

variable "nsg1" {
  type = object({
    name        = string
    subnet_name = string
  })
}

variable "nsg_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = list(string)
    destination_port_range     = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

##############################################
#             Virtual Machine                #
##############################################
variable "linux_vm_01" {
  type = object({
    name           = string
    size           = string
    admin_username = string
    admin_password = string
    os_disk_name   = string
    subnet_id      = string
    image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    nic_name = string
    ip_configuration = map(object({
      name = string
      //subnet_id = string
      private_ip_address_allocation = string
      private_ip_address            = string
    }))
  })
}

variable "linux_vm_02" {
  type = object({
    name           = string
    size           = string
    admin_username = string
    admin_password = string
    os_disk_name   = string
    subnet_id      = string
    image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    nic_name = string
    ip_configuration = map(object({
      name = string
      //subnet_id = string
      private_ip_address_allocation = string
      private_ip_address            = string
    }))
  })
}

variable "storage_account_name" {
  type = string
}