variable "rg" {
  type = object({
    name     = string
    location = string
  })

  default = {
    name     = "Test-Vexcel"
    location = "westus2"
  }
}
####################################################################
#                             Network                              #
####################################################################
variable "vnet" {
  type = object({
    name          = string
    rg_name       = string
    address_space = list(string)
  })

  default = {
    name          = "vexcel-vnet-01"
    rg_name       = "Test-Vexcel"
    address_space = ["10.0.0.0/16"]
  }
}

variable "subnet" {
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {
    subnet01 = {
      name           = "vexcel-subnet-01"
      address_prefix = "10.0.0.0/24"
    }
  }
}

####################################################################
#                        Storage Account                           #
####################################################################

variable "sa-01" {
  type = object({
    name         = string
    account_tier = string
    replication  = string
  })

  default = {
    name         = "vexcelpocstaccount"
    account_tier = "Standard"
    replication  = "LRS"
  }
}

variable "container" {
  type = map(object({
    name                  = string
    container_access_type = string
  }))
  default = {
    container1 = {
      name                  = "vexceleventhub01"
      container_access_type = "private"
    }
  }
}
####################################################################
#                           Event Hub                              #
####################################################################

variable "eventhub_namespace" {
  type = object({
    name                          = string
    sku                           = string
    minimum_tls_version           = string
    capacity                      = number
    public_network_access_enabled = bool
  })
  default = {
    name                          = "vexcel-poc"
    sku                           = "Premium"
    minimum_tls_version           = "1.2"
    capacity                      = 1
    public_network_access_enabled = true
  }
}

variable "namespace_registry" {
  type = map(object({
    name = string
  }))
  default = {}
}

variable "eventhub" {
  type = map(object({
    name              = string
    partition_count   = number
    message_retention = number
    consumer_group = map(object({
      name = string
    }))
  }))
  default = {
    "eventhub01" = {
      name              = "vexcel-hub-01"
      partition_count   = 2
      message_retention = 1
      consumer_group = {
        "consumer_group_01" = {
          name = "vexcel-hub-01-cg-01"
        }
        "consumer_group_02" = {
          name = "vexcel-hub-01-cg-02"
        }
      }
    }
    "eventhub02" = {
      name              = "vexcel-hub-02"
      partition_count   = 3
      message_retention = 2
      consumer_group = {
        "consumer_group_01" = {
          name = "vexcel-hub-02-cg-01"
        }
      }
    }
  }
}

