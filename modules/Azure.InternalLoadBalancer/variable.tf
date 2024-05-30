variable "lb" {
  description = "List of Load Balancers with configurations"
  type = list(object({
    name = string
    sku  = string
    frontend_ip_configuration = list(object({
      name = string
    }))
    bepool_name = string
    rules = list(object({
      name                           = string
      protocol                       = string
      frontend_port                  = number
      backend_port                   = number
      frontend_ip_configuration_name = string
      enable_floating_ip             = bool
    }))
    probes = list(object({
      name         = string
      port         = number
      protocol     = string
      request_path = string
    }))
  }))
  default = [
    {
      name = "internalLB1"
      sku  = "Standard"
      frontend_ip_configuration = [
        { name = "frontend1" },
        { name = "frontend2" }
      ]
      bepool_name = "backendpool1"
      rules = [
        {
          name                           = "httprule1"
          protocol                       = "Tcp"
          frontend_port                  = 80
          backend_port                   = 80
          frontend_ip_configuration_name = "frontend1"
          enable_floating_ip             = false
        },
        {
          name                           = "sshrule1"
          protocol                       = "Tcp"
          frontend_port                  = 22
          backend_port                   = 22
          frontend_ip_configuration_name = "frontend2"
          enable_floating_ip             = false
        }
      ]
      probes = [
        {
          name         = "healthprobe1"
          port         = 80
          protocol     = "Http"
          request_path = "/"
        },
        {
          name         = "sshprobe1"
          port         = 22
          protocol     = "Tcp"
          request_path = null
        }
      ]
    },
    {
      name = "internalLB2"
      sku  = "Standard"
      frontend_ip_configuration = [
        { name = "frontend3" }
      ]
      bepool_name = "backendpool2"
      rules = [
        {
          name                           = "httprule2"
          protocol                       = "Tcp"
          frontend_port                  = 8080
          backend_port                   = 80
          frontend_ip_configuration_name = "frontend3"
          enable_floating_ip             = false
        }
      ]
      probes = [
        {
          name         = "healthprobe2"
          port         = 80
          protocol     = "Http"
          request_path = "/"
        }
      ]
    }
  ]
}

variable "location" {
  description = "The location of the Load Balancers"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "az-rg-01"
}

variable "subnet_id" {
  description = "The subnet ID for the frontend IP configuration"
  type        = string
  default     = "/subscriptions/5a395407-07f8-47a9-b8bf-92c05227486c/resourceGroups/az-rg-01/providers/Microsoft.Network/virtualNetworks/az-vnet-01/subnets/az-subnet-01"
}
