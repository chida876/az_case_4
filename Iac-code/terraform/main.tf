terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azureL2"
    storage_account_name = "case4"
    container_name       = "case4"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "0398a2d0-f281-4db0-8ca7-aff9eb979a9c"
  client_id       = "d3a0d109-ae5d-48fd-b799-df378d24dee6"
  tenant_id       = "0eaea45a-611c-46c5-b864-19f5bd2e30bd"
  client_secret   = "2xB8Q~IVs.PG2tOAaV7N7wc4soSonGm0vnI5hcmh"
}


data "azurerm_resource_group" "rg" {
  name = "azureL2"
}


resource "azurerm_service_plan" "plan" {
  name                = "${var.planname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app" {
  name                = "${var.appname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = true
  }
}
