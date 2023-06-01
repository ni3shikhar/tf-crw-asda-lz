#create MS SQL database
resource "azurerm_mssql_database" "sqldb-asda" {
  name           = "sqldb-${var.business_unit}-${var.environment}"
  server_id      = azurerm_mssql_server.sql-asda.id
  #collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "BasePrice"
  #max_size_gb    = 4
  #read_scale     = true
  sku_name       = "GP_Gen5_4"
  zone_redundant = false
  storage_account_type = "Geo"

  /*tags = {
    foo = "bar"
  }*/
}