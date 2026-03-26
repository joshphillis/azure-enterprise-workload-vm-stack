resource "azurerm_resource_group" "vm_rg" {
  name     = var.vm_resource_group
  location = local.workload_location
}

#############################################
# Remote State: Azure Enterprise Landing Zone
#############################################

data "terraform_remote_state" "landing_zone" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate-aks-enterprise"
    storage_account_name = "sttfstateaksenterprise01"
    container_name       = "tfstate"
    key                  = "landing-zone.terraform.tfstate"
  }
}

#############################################
# Locals from Landing Zone Outputs
#############################################

locals {
  workload_location  = data.terraform_remote_state.landing_zone.outputs.location
  workload_subnet_id = data.terraform_remote_state.landing_zone.outputs.hub_default_subnet_id
}