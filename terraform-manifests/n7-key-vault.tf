#create Azure Kay Vault
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv-asda" {
  name                        = "kv-${var.business_unit}-${var.environment}-${random_string.random.id}"
  location                    = azurerm_resource_group.rg-asda.location
  resource_group_name         = azurerm_resource_group.rg-asda.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","GetRotationPolicy","SetRotationPolicy","Rotate",
    ]

    secret_permissions = [
      "Get","List","Set","Delete","Recover","Backup","Restore",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","GetRotationPolicy","SetRotationPolicy","Rotate",
    ]

    secret_permissions = [
      "Get","List","Set","Delete","Recover","Backup","Restore",
    ]

    storage_permissions = [
      "Get",
    ]
  }
  network_acls {
    default_action             = "Deny"
    ip_rules                   = ["159.246.20.2","159.246.40.2"]
    virtual_network_subnet_ids = [azurerm_subnet.snet-core.id,azurerm_subnet.snet-privateendpoints.id]
    bypass                     = "AzureServices"
  }
}