terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  backend "azurerm" {
    resource_group_name  = "patricksdemostorage"
    storage_account_name = "patricksdemostorage"
    container_name       = "blogtfstate"
    key                  = "acr.demo.tfstate"
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = "******************************"
}

resource "azurerm_resource_group" "rg" {
  name     = "blog_demo_resource_group"
  location = "westeurope"
}

resource "azurerm_container_registry" "acr_demo" {
  name                = "blogcontainerregistry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}