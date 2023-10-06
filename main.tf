terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "9f9e5799-02b9-4f61-b7fa-6ebe06d07373"
  tenant_id = "4b35b7f4-e93d-4b85-a7fd-dfca245c5d27"
  client_id = "2376e889-5575-4bce-afa5-fe8adf0744bf"
  client_secret = "_Jb8Q~Li7lJhtBdBcz4LGfIRmPa4MWOaIo5kjbDr"
  features {
    
  }
}

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "North Europe"
}

resource "azurerm_storage_account" "appstore1308" {
  name                     = "strluizandresalomao1308"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [ 
    azurerm_resource_group.appgrp 
    ]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "strluizandresalomao1308"
  container_access_type = "blob"
  depends_on = [ 
    azurerm_storage_account.appstore1308
   ]
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = "strluizandresalomao1308"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "main.tf"
  depends_on = [ 
    azurerm_storage_container.data
   ]
}