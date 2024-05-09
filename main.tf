##############################################
#              Resource Groups               #
##############################################


module "rg_1" {
  source   = "./modules/Azure.ResourceGroup"
  name     = var.rg_1["name"]
  location = var.rg_1["location"]
  tags     = var.tags
}

##############################################
#              VNet and Subnet               #
##############################################

module "vnet_1" {
  source        = "./modules/Azure.VirtualNetwork"
  name          = var.vnet_1["name"]
  location      = var.rg_1["location"]
  rg_name       = var.rg_1["name"]
  address_space = var.vnet_1["address_space"]
  tags          = var.tags
  subnet        = var.subnets
}

##############################################
#                    NSG                     #
##############################################
/*data "azurerm_subnet" "nsg_id1" {
  name                 = var.nsg1["subnet_name"]
  virtual_network_name = var.vnet_1["name"]
  resource_group_name  = var.rg_1["name"]
}


module "nsg1" {
  source    = "./modules/Azure.NSG"
  name      = var.nsg1["name"]
  location  = var.rg_1["location"]
  rg_name   = var.rg_1["name"]
  subnet_id = data.azurerm_subnet.nsg_id1.id
  nsg_rules = var.nsg_rules
  tags      = var.tags
  depends_on = [
    module.rg_1,
    module.vnet_1
  ]
}*/