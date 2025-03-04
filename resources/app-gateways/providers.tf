terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    resource_group_name  = "XxXX.-p-rgp-automation-001"
    storage_account_name = "XXXX.pstalsautomation002"
    container_name       = "appgateway-state"
    key                  = "terraform.tfstate."
  }

}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}