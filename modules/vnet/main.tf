resource azurerm_virtual_network vnet {
  name                = var.subnet_name
  address_space       = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = var.rg_name
  
  tags = {
    Environment = "Terraform Getting Started"
  }
}