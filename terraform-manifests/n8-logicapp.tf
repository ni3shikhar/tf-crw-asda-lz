#Create consumption tier logic app
resource "azurerm_logic_app_workflow" "la-asda" {
  name                = "la-${var.business_unit}-dwh-${var.environment}"
  location            = azurerm_resource_group.rg-asda.location
  resource_group_name = azurerm_resource_group.rg-asda.name

  identity {
    type = "SystemAssigned"
  }
}