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

provider "azurerm" {
  features {}
}

resource azurerm_resource_group rg {
  name     = var.resource_group_name
  location = var.location
}

resource azurerm_virtual_network vnet {
  name                = "myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  
  tags = {
    Environment = "Terraform Getting Started"
  }
}