variable "eventhub_namespace" {
  type = string
}

variable "rg_name" {
 type = string 
}

variable "name" {
  type = string
}

variable "partition_count" {
  type = number
}

variable "message_retention" {
  type = number
}

variable "consumer_group" {
  type = map(object({
    name = string
  }))
  default = { }
  }