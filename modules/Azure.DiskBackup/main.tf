data "azurerm_data_protection_backup_vault" "vault" {
  name                = "testvault"
  resource_group_name = "test2"
}

data "azurerm_managed_disk" "disk1" {
  resource_group_name = "test2"
  name = "testvm3_OsDisk_1_7a7b1aded02a499c8f6f6917cd7de037"
}

resource "azurerm_data_protection_backup_instance_disk" "example" {
  name                = "my-backup-instance"
  location            = "eastus"
  snapshot_resource_group_name = "test2"
  disk_id             = data.azurerm_managed_disk.disk1.id
  backup_policy_id    = "/subscriptions/f4a270f4-c469-4215-bef6-b4abaea6815e/resourceGroups/test2/providers/Microsoft.DataProtection/backupVaults/testvault/backupPolicies/defaultpolicy"
  //backup_policy_id    =azurerm_data_protection_backup_policy_disk.disk_policy.id 
  vault_id            = data.azurerm_data_protection_backup_vault.vault.id
}