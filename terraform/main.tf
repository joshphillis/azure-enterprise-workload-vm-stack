#############################################
# Remote State: Azure Enterprise Landing Zone
#############################################

data "terraform_remote_state" "landing_zone" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.lz_state_rg
    storage_account_name = var.lz_state_sa
    container_name       = var.lz_state_container
    key                  = var.lz_state_key
  }
}

#############################################
# Locals from Landing Zone Outputs
#############################################

locals {
  workload_rg_name   = data.terraform_remote_state.landing_zone.outputs.workload_rg_name
  workload_location  = data.terraform_remote_state.landing_zone.outputs.location
  workload_subnet_id = data.terraform_remote_state.landing_zone.outputs.workload_subnet_id
  log_analytics_id   = data.terraform_remote_state.landing_zone.outputs.log_analytics_workspace_id
}