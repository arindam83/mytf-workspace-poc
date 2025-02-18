terraform {
  cloud {
    organization = "arindam"

    workspaces {
      name = "my-tf-kv-01"
    }
  }
}
provider "azurerm" {
  features {}
 # Replace with appId
/*    subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  */
}


resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}
resource "azurerm_resource_group" "rg2" {
  name     = "myResourceGroup2"
  location = "East US"
}

module "my_module_rg" {
  source  = "app.terraform.io/arindam/resource-group/azurerm"
  version = "1.0.0"  # Adjust version if different

  resource_group_name = "module-created-rg"
  location           = "East US"
  tags = {
    environment = "dev"
    managed_by  = "terraform-module"
  }
}

module "my_module_rg" {
  source  = "app.terraform.io/arindam/resource-group/azurerm"
  version = "1.0.0"  # Adjust version if different

  resource_group_name = "module-created-rg-new"
  location           = "East US"
  tags = {
    environment = "dev"
    managed_by  = "terraform-module"
  }
}
resource "azurerm_storage_account" "sa" {
  name                     = "arinhsa01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
/*
resource "azurerm_storage_container" "container" {
  name                  = "function-app-container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
*/


