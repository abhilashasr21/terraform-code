variable "sa_name" {
  type = string
  validation {
    condition     = can(regex("^[a-z]+$", var.sa_name))
    error_message = "The Storage Account name must be all lowercase letters."
  }
}

variable "rg_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westus2"
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_tier" {
  type = string
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The Storage account can be Standard or Premium"
  }
}

variable "replication" {
  type = string
}

variable "encryption_scope" {
  type    = bool
  default = false
}