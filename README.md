Azure Enterprise Workload VM Stack

📘 Overview

This repository deploys a pair of virtual machines (Windows and Linux) into an existing Azure enterprise landing zone. It is designed to cleanly separate workload resources from platform infrastructure, following best practices for remote state integration, private networking, and modular Terraform architecture.

🏗️ Architecture

Landing Zone: Provides hub/spoke VNets, subnets, NSGs, diagnostics, Bastion, and governance.

Workload Layer (this repo):

1 Windows VM

1 Linux VM with SSH key

2 NICs (no public IPs)

Remote state integration with landing zone

Boot diagnostics disabled or delegated to platform

🔗 Remote State Integration

This repo consumes outputs from the landing zone via terraform_remote_state:

data "terraform_remote_state" "landing_zone" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.lz_state_rg
    storage_account_name = var.lz_state_sa
    container_name       = var.lz_state_container
    key                  = var.lz_state_key
  }
}

📦 Modules and Files

File

Purpose

main.tf

Remote state + locals

providers.tf

AzureRM provider and backend config

variables.tf

Workload-specific variables

outputs.tf

VM names, private IPs

network.tf

NICs for Windows and Linux VMs

vm_windows.tf

Windows VM resource

vm_linux.tf

Linux VM + SSH key generation

terraform.tfvars

Runtime values for remote state and VMs

🔐 Security and Access

No public IPs are created

SSH access via Bastion (provided by landing zone)

Admin credentials and SSH keys are managed via variables

🚀 Usage

terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

📥 Inputs (from variables.tf)

windows_vm_name, linux_vm_name

windows_vm_size, linux_vm_size

vm_os_image, vm_os_disk_type

admin_username, admin_password

tags

Remote state backend variables: lz_state_rg, lz_state_sa, lz_state_container, lz_state_key

📤 Outputs

windows_vm_private_ip

linux_vm_private_ip

windows_vm_name

linux_vm_name

🧱 Integration Notes

Subnet, resource group, and location are pulled from landing zone

NSGs, diagnostics, and Bastion are managed by platform repo

This repo is workload-only and does not duplicate platform resources
