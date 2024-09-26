terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-azure-tf"
    storage_account_name = "saaztf"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  #skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  resource_provider_registrations = "none"
  #client_id       = "c2340add-d9d9-4a4d-a975-24b44bf15478"
  #tenant_id       = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  subscription_id = "5a395407-07f8-47a9-b8bf-92c05227486c"

}