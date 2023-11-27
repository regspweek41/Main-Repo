# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
    subscription_id = "491e1121-c626-46e3-98ba-98f9f0434964"
    tenant_id = "2047b1bd-994d-4366-9d87-647dac583343"
    client_id = "a78d2362-7c1d-475b-b06c-683634019705"
    client_secret = "aSR8Q~UzW_2fWfpMnAHLnY~04qdEl~tjRbS0XbUB"
  
}


data "azurerm_resource_group" "example" {
  name     = var.rgname
}

module "subnet" {
  source = "./modules/azure-subnet"
  subnetname = var.subnetname
  rgname = var.rgname
  nertworkname = var.nertworkname
  address = var.address
  
}

module "privatednszone" {
  source = "./modules/azure-privatednszone"
  dnsname = var.dnsname
  rgname = var.rgname

}

module "postgresdb" {
  source = "./modules/azure-postgres-db"
  dbname = var.dbname
  rgname = var.rgname
  location = var.location
  delegated_subnet_id = module.subnet.subnet-id
  private_dns_zone_id = module.privatednszone.privatesdns-id
  administrator_login = var.administrator_login
  administrator_password = var.administrator_password
  zone = var.zone
  storage_mb = var.storage_mb
  sku_name = var.sku_name


}