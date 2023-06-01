#create SQL Server

resource "azurerm_mssql_server" "sql-asda" {
  name                         = "sql-dwh-${var.business_unit}"
  resource_group_name          = azurerm_resource_group.rg-asda.name
  location                     = azurerm_resource_group.rg-asda.location
  version                      = "12.0"
  administrator_login          = "mradministrator" #replate this with sensitive variable types
  administrator_login_password = "thisIsDog11" #replace this with sensitive variable types
  minimum_tls_version = "1.2"
  public_network_access_enabled = true
  azuread_administrator {
    login_username = "nitin.shikhare@kadamorg.onmicrosoft.com"
    object_id = var.id_azure_sql_server_admin
  }
  identity {
    type = "SystemAssigned"
  }
  /*threat_detection_policy {
    
  }
  tags = {
    environment = "production"
  }*/
}

# enable sql server TDE
resource "azurerm_mssql_server_transparent_data_encryption" "sql-tde" {
  server_id = azurerm_mssql_server.sql-asda.id
}


#Start of auditing - enable sql server auditing
resource "azurerm_monitor_diagnostic_setting" "diag-asda" {
  name                       = "ds-settings"
  target_resource_id         = "${azurerm_mssql_server.sql-asda.id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la-asda.id

  /*enabled_log {
    category = "AuditEvent"
    enabled  = true

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

  lifecycle {
    ignore_changes = [log, metric]
  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "audit-asda1" {
  database_id            = "${azurerm_mssql_database.sqldb-asda.id}"
  log_monitoring_enabled = true
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit-asda1" {
  server_id              = azurerm_mssql_server.sql-asda.id
  log_monitoring_enabled = true
}
#End of auditing block

#create virtual network rule for sql server
resource "azurerm_mssql_virtual_network_rule" "sql-vnet-rule1" {
  name      = "sql-vnet-rule1"
  server_id = azurerm_mssql_server.sql-asda.id
  subnet_id = azurerm_subnet.snet-core.id
}
resource "azurerm_mssql_virtual_network_rule" "sql-vnet-rule2" {
  name      = "sql-vnet-rule2"
  server_id = azurerm_mssql_server.sql-asda.id
  subnet_id = azurerm_subnet.snet-privateendpoints.id
}

#sqlserver firewall rule to allow traffic from crowe VPNs
resource "azurerm_mssql_firewall_rule" "sql-fw-crowe1" {
  name                = "AllowFromCroweVPN1"
  server_id         = azurerm_mssql_server.sql-asda.id
  start_ip_address    = "159.246.20.2"
  end_ip_address      = "159.246.20.2"
}
#sqlserver firewall rule to allow traffic from crowe VPNs
resource "azurerm_mssql_firewall_rule" "sql-fw-crowe2" {
  name                = "AllowFromCroweVPN2"
  server_id         = azurerm_mssql_server.sql-asda.id
  start_ip_address    = "159.246.40.2"
  end_ip_address      = "159.246.40.2"
}

#sqlserver firewall rule exception - allow access to azure services and resources
resource "azurerm_mssql_firewall_rule" "sql-fw-Azure" {
  name                = "AllowAccessToAzureServices"
  server_id         = azurerm_mssql_server.sql-asda.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

