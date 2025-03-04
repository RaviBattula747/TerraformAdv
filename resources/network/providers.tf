terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    subscription_id      = "b6XXXXXXXXXXXXXXXXXXXXXXXXXafa"
    resource_group_name  = "scem-p-rgp-automation-001"
    storage_account_name = "scempstalsautomation002"
    container_name       = "network-state"
    key                  = "terraform.tfstate."
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "connectivity"
  features {}
  subscription_id = "5XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5"
}

provider "azurerm" {
  alias = "cybersecurity"
  features {}
  subscription_id = "735XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX54f3"
}

provider "azurerm" {
  alias = "identity"
  features {}
  subscription_id = "5XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5"
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = "15XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5a"
}

provider "azurerm" {
  alias = "monitoring"
  features {}
  subscription_id = "85XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5"
}

provider "azurerm" {
  alias = "automation"
  features {}
  subscription_id = "b65XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5"
}

provider "azurerm" {
  alias = "anv"
  features {}
  subscription_id = "f7XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXe60f"
}

provider "azurerm" {
  alias = "anv-np"
  features {}
  subscription_id = "d3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX32"
}

provider "azurerm" {
  alias = "col"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXa"
}

provider "azurerm" {
  alias = "col-np"
  features {}
  subscription_id = "29XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXd4"
}

provider "azurerm" {
  alias = "eng"
  features {}
  subscription_id = "d5XXXXXXXXXXXXXXXXXXXXXXXXXXX872"
}


provider "azurerm" {
  alias = "eng-np"
  features {}
  subscription_id = "e0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX55"
}

provider "azurerm" {
  alias = "ntx"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "ntx-np"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "rtc"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "rtc-np"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}


provider "azurerm" {
  alias = "tdm"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "tdm-np"
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXc"
}

provider "azurerm" {
  alias = "vrs"
  features {}
  subscription_id = "cXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "vrs-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

}


provider "azurerm" {
  alias = "apg"
  features {}
  subscription_id = "bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "apg-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "ase"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "ase-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}


provider "azurerm" {
  alias = "emp"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "emp-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "nar"
  features {}
  subscription_id = "93XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX5"
}

provider "azurerm" {
  alias = "nar-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "roc"
  features {}
  subscription_id = "a3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "roc-np"
  features {}
  subscription_id = "33XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX2"
}

provider "azurerm" {
  alias = "sca"
  features {}
  subscription_id = "a3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "azurerm" {
  alias = "sca-np"
  features {}
  subscription_id = "0f3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXc68"
}

provider "azurerm" {
  alias = "jks"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
}

provider "azurerm" {
  alias = "jks-np"
  features {}
  subscription_id = "13XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXd7"
}

provider "azurerm" {
  alias = "wtr"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX9"
}

provider "azurerm" {
  alias = "wtr-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX9"
}

provider "azurerm" {
  alias = "isr"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX9"
}

provider "azurerm" {
  alias = "isr-np"
  features {}
  subscription_id = "3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX9"
}