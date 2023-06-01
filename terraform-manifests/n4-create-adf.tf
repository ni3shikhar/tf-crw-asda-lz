resource "azurerm_data_factory" "adf-asda" {
  name                = "adf-${var.business_unit}-${var.environment}"
  location            = azurerm_resource_group.rg-asda.location
  resource_group_name = azurerm_resource_group.rg-asda.name
  managed_virtual_network_enabled = true
  public_network_enabled = true
  identity {
    type = "SystemAssigned"
  }
  /*github_configuration {
    account_name =  ""
    branch_name = ""
    git_url = ""
    repository_name = ""
    root_folder = ""
  }*/

  //Add diagnostics settings    
}

data "azuread_service_principal" "data_factory_managed_identity" {
  #object_id = azurerm_data_factory.df.identity.0.principal_id
  display_name =  "adf-${var.business_unit}-${var.environment}"
  depends_on = [ azurerm_data_factory.adf-asda ]
}

resource "azurerm_key_vault_access_policy" "adf-principal" {
  key_vault_id = azurerm_key_vault.kv-asda.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.data_factory_managed_identity.object_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
      "Get","List"
    ]
}

resource "azurerm_data_factory_managed_private_endpoint" "mpe-stg" {
  name               = "mpe-storage"
  data_factory_id    = azurerm_data_factory.adf-asda.id
  target_resource_id = azurerm_storage_account.stg-asda.id
  subresource_name   = "blob"
}

resource "azurerm_data_factory_managed_private_endpoint" "mpe-kv" {
  name               = "mpe-kv"
  data_factory_id    = azurerm_data_factory.adf-asda.id
  target_resource_id = azurerm_key_vault.kv-asda.id
  subresource_name   = "vault"
}

resource "azurerm_data_factory_managed_private_endpoint" "mpe-sql" {
  name               = "mpe-sql"
  data_factory_id    = azurerm_data_factory.adf-asda.id
  target_resource_id = azurerm_mssql_server.sql-asda.id
  subresource_name   = "sqlServer"
}