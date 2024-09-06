variable "name" {
  type    = string
  default = "sadevtools3prodeus2"
}

variable "rg_name" {
  type    = string
  default = "Test-01"
}

variable "account_tier" {
  type    = string
  default = "Premium"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "fileshare_list" {
  type = map(object({
    name                 = string
    storage_account_name = string
    access_tier          = string
    enabled_protocol     = string
    quota                = number
  }))
  description = "List of file shares to be created."
  default = {
    /*share1 = {
      name                 = "wus3fbatlassian2-bitbucket-prod"
      storage_account_name = "sadevtools3prodeus2"
      access_tier          = "Premium"
      enabled_protocol     = "NFS"
      quota                = 500
    }*/
    share2 = {
      name                 = "wus3fbatlassian2-confluence-prod"
      storage_account_name = "sadevtools3prodeus2"
      access_tier          = "Premium"
      enabled_protocol     = "NFS"
      quota                = 600
    }
    share3 = {
      name                 = "wus3fbatlassian2-jira-prod"
      storage_account_name = "sadevtools3prodeus2"
      access_tier          = "Premium"
      enabled_protocol     = "NFS"
      quota                = 500
    }
    share4 = {
      name                 = "deployecomjenkins-prod"
      storage_account_name = "sadevtools3prodeus2"
      access_tier          = "Premium"
      enabled_protocol     = "NFS"
      quota                = 250
    }
  }
}