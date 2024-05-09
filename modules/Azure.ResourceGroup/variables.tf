variable "name" {
  type = string
}

variable "location" {
  type = string
  default = "eastus2"
}

variable "tags" {
  type = map(string)
  default = {
    Deployment = "terraform"
    Environment = "Test"
  }
}