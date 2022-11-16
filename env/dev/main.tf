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
    hostname = "app.terraform.io"
    organization = "salessquare"

    workspaces {
      name = "terraform"
    }
  }
}

provider "azurerm" {
  features {}
}

resource azurerm_resource_group rg {
  rg_name   = var.resource_group_name
  location = var.location
}
module "resourcegroup" {
  source = "../../modules/resourcegroup"
  location = var.location
}
module "vnet" {
  source = "../../modules/vnet"
  subnet_name = "myTFVnet"
  rg_name = module.resourcegroup.name
  location = var.location
}