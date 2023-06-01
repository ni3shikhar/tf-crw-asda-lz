#create diagnostics settings for virtual networks
resource "azurerm_monitor_diagnostic_setting" "diag-vnet" {
  name               = "diag-vnet"
  target_resource_id = azurerm_virtual_network.vnet-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

#create diagnostics settings for storage accounts
resource "azurerm_monitor_diagnostic_setting" "diag-stg" {
  name               = "diag-stg"
  target_resource_id = azurerm_storage_account.stg-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

#create diagnostics settings for adf
resource "azurerm_monitor_diagnostic_setting" "diag-adf" {
  name               = "diag-adf"
  target_resource_id = azurerm_data_factory.adf-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}


#create diagnostics settings for AAS
resource "azurerm_monitor_diagnostic_setting" "diag-aas" {
  name               = "diag-aas"
  target_resource_id = azurerm_analysis_services_server.aas-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

#create diagnostics settings for KV
resource "azurerm_monitor_diagnostic_setting" "diag-kv" {
  name               = "diag-kv"
  target_resource_id = azurerm_key_vault.kv-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

#create diagnostics settings for Logic App
resource "azurerm_monitor_diagnostic_setting" "diag-la" {
  name               = "diag-la"
  target_resource_id = azurerm_logic_app_workflow.la-asda.id
  #storage_account_id = azurerm_storage_account.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }*/

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}