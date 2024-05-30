##############################################
#               Subscription                 #
##############################################
subscription_id = "f4a270f4-c469-4215-bef6-b4abaea6815e"

##############################################
#              Resource Groups               #
##############################################
rg_1 = {
  name     = "az-rg-01"
  location = "eastus2"
}

##############################################
#                  Network                   #
##############################################
vnet_1 = {
  name          = "az-vnet-01"
  address_space = ["10.0.0.0/16"]
}

subnets = {
  subnet_1 = {
    name           = "az-subnet-01"
    address_prefix = "10.0.0.0/26"
  },
  subnet_2 = {
    name           = "az-subnet-02"
    address_prefix = "10.0.1.0/26"
  },
  subnet_3 = {
    name           = "az-subnet-03"
    address_prefix = "10.0.2.0/26"
  }
}

nsg1 = {
  name        = "az-nsg-02"
  subnet_name = "az-subnet-01"
}
nsg_rules = {
  "rdp_connection" = {
    name                       = "rdp_connection"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = ["*"]
    destination_port_range     = ["*"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


linux_vm_01 = {
  name           = "az-linux-01"
  size           = "Standard_D2s_v3"
  admin_username = "TestAdmin"
  admin_password = "TestAdmin@123"
  os_disk_name   = "az-linux-01-OS_disk"
  subnet_id      = "az-subnet-03"
  image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "90-gen2"
    version   = "latest"
  }
  nic_name = "az-linux-01-nic"
  ip_configuration = {
    az-linux-01-nic01 = {
      name                          = "az-linux-01-nic01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.2.7"
    }
  }
}

linux_vm_02 = {
  name           = "az-linux-02"
  size           = "Standard_D2s_v3"
  admin_username = "TestAdmin"
  admin_password = "TestAdmin@123"
  os_disk_name   = "az-linux-02-OS_disk"
  subnet_id      = "az-subnet-03"
  image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "90-gen2"
    version   = "latest"
  }
  nic_name = "az-linux-02-nic"
  ip_configuration = {
    az-linux-01-nic01 = {
      name                          = "az-linux-01-nic01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.2.8"
    }
  }
}

tags = {
  "Language"         = "Terraform"
  "Environment"      = "Test"
  "Deployment Group" = "Azure CLI"
  "Critical"         = "5"
}

storage_account_name = "linuxdiagteststaccount01"
sas_token            = "se=2037-12-31T23%3A59%3A00Z&sp=wlacu&sv=2022-11-02&ss=tb&srt=co&sig=A2XNcDbh6E0hoMUtlDmh5UNst1U4czIqJ%2B6LauYa9yQ%3D"