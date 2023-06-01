#create log analytics workspace
resource "azurerm_log_analytics_workspace" "la-asda" {
  name                = "law-${var.business_unit}-${var.environment}"
  location            = azurerm_resource_group.rg-asda.location
  resource_group_name = azurerm_resource_group.rg-asda.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}