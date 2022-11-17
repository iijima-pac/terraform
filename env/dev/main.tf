# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.31.0"
    }
  }

  required_version = "~> 1.3.4"
}
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "salessquare"

    workspaces {
      name = "terraform"
    }
  }
}

provider "azurerm" {
  features {}
}
module "resourcegroup" {
  source   = "../../modules/resourcegroup"
  location = var.location
  rg_name  = var.resource_group_name
}
module "vnet" {
  source      = "../../modules/vnet"
  subnet_name = "myTFVnet"
  rg_name     = module.resourcegroup.name
  location    = var.location
}
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = module.resourcegroup.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}