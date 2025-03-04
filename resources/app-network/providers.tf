terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "b6d0cde9-e9f0-4023-bf75-a59365052afa"
    resource_group_name  = "XXXX.-p-rgp-automation-001"
    storage_account_name = "XXXX.pstalsautomation002"
    container_name       = "network-app-state"
    key                  = "terraform.tfstate."
  }

}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "apg"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "apg-np"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "ase"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "ase-np"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}


provider "azurerm" {
  alias = "emp"
  features {}
  subscription_id = "8XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "emp-np"
  features {}
  subscription_id = "783XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "nar"
  features {}
  subscription_id = "98XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXe05"
}

provider "azurerm" {
  alias = "nar-np"
  features {}
  subscription_id = "951XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXaf050"
}

provider "azurerm" {
  alias = "roc"
  features {}
  subscription_id = "aeXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXc76af"
}

provider "azurerm" {
  alias = "roc-np"
  features {}
  subscription_id = "3440XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX2"
}

provider "azurerm" {
  alias = "sca"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb"
}

provider "azurerm" {
  alias = "sca-np"
  features {}
  subscription_id = "0f4461XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX8"
}

provider "azurerm" {
  alias = "jks"
  features {}
  subscription_id = "76518XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX1"
}

provider "azurerm" {
  alias = "jks-np"
  features {}
  subscription_id = "172aXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "wtr"
  features {}
  subscription_id = "a17dXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "wtr-np"
  features {}
  subscription_id = "e2XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX3"
}

provider "azurerm" {
  alias = "psw"
  features {}
  subscription_id = "1cdXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "psw-np"
  features {}
  subscription_id = "24XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "wsm"
  features {}
  subscription_id = "47XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "wsm-np"
  features {}
  subscription_id = "10XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "appservice"
  features {}
  subscription_id = "06XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "appservice-np"
  features {}
  subscription_id = "5cXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "mic"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX8"
}

provider "azurerm" {
  alias = "mic-np"
  features {}
  subscription_id = "eXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}