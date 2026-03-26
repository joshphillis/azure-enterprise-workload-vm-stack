terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-aks-enterprise"
    storage_account_name = "sttfstateaksenterprise01"
    container_name       = "tfstate"
    key                  = "vm-workload.terraform.tfstate"
  }
}