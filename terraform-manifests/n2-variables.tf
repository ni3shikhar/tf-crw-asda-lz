# Input Variables

# 1. Business Unit Name
variable "business_unit" {
  description = "Business Unit Name"
  type = string
  default = "crw"
}
# 2. Environment Name
variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}

# 4. Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
}

# 6. Virtual Network Address - Dev
variable "vnet_address_space_asda" {
  description = "Virtual Network Address Space for Dev Environment"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

# 13. core subnet
variable "asda_subent_address_prefix" {
  description = "D365 subnet address prefix"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

# 13. Privateendpoint core subnet
variable "pe_subent_address_prefix" {
  description = "D365 subnet address prefix"
  type = list(string)
  default = [ "10.0.2.0/24" ]
}

#Azure MS SQL Azure Admin Username
variable "name_azure_sql_server_admin" {
  description = "Username of the MS SQL Server Administrator"
  type = string
  default = "nitin.shikhare@kadamorg.onmicrosoft.com" //pass this as inline parameter while deployment
}

#Azure MS SQL Azure Admin Object ID
variable "id_azure_sql_server_admin" {
  description = "Object ID of the MS SQL Server Administrator"
  type = string
  default = "db2f7ba0-dca2-48b1-8083-374f235d1e10" //pass this as inline parameter while deployment
}

#Azure Analysis Service Server Adminstrators
variable "aas_admins" {
  description = "Azure Analysis Service Server Adminstrators"
  type = list(string)
  default = [ "nitin.shikhare@kadamorg.onmicrosoft.com" ] #define this as a sensitive variable.
}