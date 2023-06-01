# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg-asda" {
  #name = "${var.business_unit}-${var.environment}-${var.resoure_group_name}"
  #name = local.rg_name
  name = "rg-${var.business_unit}-${var.environment}"
  location = var.resoure_group_location
  #tags = var.common_tags
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet-asda" {
  name                = "vnet-${var.business_unit}-${var.environment}"
  address_space       = var.vnet_address_space_asda
  location            = azurerm_resource_group.rg-asda.location
  resource_group_name = azurerm_resource_group.rg-asda.name
  #tags = var.common_tags 
}

resource "azurerm_subnet" "snet-core" {
  name                 = "snet-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg-asda.name
  virtual_network_name = azurerm_virtual_network.vnet-asda.name
  address_prefixes     = var.asda_subent_address_prefix
  service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
 
}

resource "azurerm_subnet" "snet-privateendpoints" {
  name                 = "snet-privateendpoints"
  resource_group_name  = azurerm_resource_group.rg-asda.name
  virtual_network_name = azurerm_virtual_network.vnet-asda.name
  address_prefixes     = var.pe_subent_address_prefix
  service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

#create storage account for dev activities
resource "azurerm_storage_account" "stg-asda" {
  name                     = "stglog${var.business_unit}dev${random_string.random.id}"
  resource_group_name      = azurerm_resource_group.rg-asda.name
  location                 = azurerm_resource_group.rg-asda.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #public_network_access_enabled = true 

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["159.246.20.2","159.246.40.2"]
    virtual_network_subnet_ids = [azurerm_subnet.snet-core.id,azurerm_subnet.snet-privateendpoints.id]
    bypass                     = ["Metrics"]
  }

  /*tags = {
    environment = "staging"
  }*/
}

/*
#create storage account netowrk firewall rules
resource "azurerm_storage_account_network_rules" "example" {
  storage_account_id = azurerm_storage_account.stg-asda.id

  default_action             = "Allow"
  ip_rules                   = ["159.246.20.2","159.246.40.2"]
  virtual_network_subnet_ids = []
  bypass                     = ["Metrics"]
}*/
resource "random_string" "random" {
  length           = 6
  special = false
  upper = false
  numeric = false
}

