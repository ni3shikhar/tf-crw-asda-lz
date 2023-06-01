# Create Analysis Service Server
resource "azurerm_analysis_services_server" "aas-asda" {
  name                    = "aas${var.business_unit}${var.environment}"
  location                = azurerm_resource_group.rg-asda.location
  resource_group_name     = azurerm_resource_group.rg-asda.name
  sku                     = "B1"
  admin_users             = var.aas_admins
  enable_power_bi_service = true

  ipv4_firewall_rule {
    name        = "AllowFromCroweVPN1"
    range_start = "159.246.20.2"
    range_end   = "159.246.20.2"
  }
  ipv4_firewall_rule {
    name        = "AllowFromCroweVPN2"
    range_start = "159.246.40.2"
    range_end   = "159.246.40.2"
  }

  /*tags = {
    abc = 123
  }*/
}