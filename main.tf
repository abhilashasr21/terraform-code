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
/*module "nsg1" {
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
}

##############################################
#             Virtual Machine                #
##############################################

data "azurerm_subnet" "subnet_id" {
  name                 = var.linux_vm_01["subnet_id"]
  resource_group_name  = var.rg_1["name"]
  virtual_network_name = var.vnet_1["name"]
}

module "linux_vm_01" {
  source         = "./modules/Azure.VirtualMachine.Linux"
  name           = var.linux_vm_01["name"]
  rg_name        = var.rg_1["name"]
  location       = var.rg_1["location"]
  size           = var.linux_vm_01["size"]
  admin_username = var.linux_vm_01["admin_username"]
  admin_password = var.linux_vm_01["admin_password"]
  os_disk_name   = var.linux_vm_01["os_disk_name"]
  //caching         = var.linux_vm_01["caching"]
  //storage_type    = var.linux_vm_01["storage_type"]
  image_reference  = var.linux_vm_01["image_reference"]
  nic_name         = var.linux_vm_01["nic_name"]
  ip_configuration = var.linux_vm_01["ip_configuration"]
  subnet_id        = data.azurerm_subnet.subnet_id.id
  tags             = var.tags
}*/

##############################################
#             Storage Account                #
##############################################

module "st_account" {
  source  = "./modules/Azure.StorageAccount"
  name    = var.storage_account_name
  rg_name = var.rg_1["name"]
}
##############################################
#          Internal Load Balancer            #
##############################################
module "lb" {
  source = "./modules/Azure.InternalLoadBalancer"
}