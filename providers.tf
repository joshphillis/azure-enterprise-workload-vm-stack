terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = var.workload_state_rg
    storage_account_name = var.workload_state_sa
    container_name       = var.workload_state_container
    key                  = "workload-vm-stack.tfstate"
  }
}

provider "azurerm" {
  features {}
}