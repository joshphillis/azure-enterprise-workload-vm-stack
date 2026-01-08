###############################
# Landing Zone Remote State
###############################

variable "lz_state_rg" {
  description = "Resource group containing landing zone state"
  type        = string
}

variable "lz_state_sa" {
  description = "Storage account for landing zone state"
  type        = string
}

variable "lz_state_container" {
  description = "Container for landing zone state"
  type        = string
}

variable "lz_state_key" {
  description = "State file name for landing zone"
  type        = string
}

###############################
# Workload State Backend
###############################

variable "workload_state_rg" {
  type        = string
  description = "Resource group for workload Terraform state"
}

variable "workload_state_sa" {
  type        = string
  description = "Storage account for workload Terraform state"
}

variable "workload_state_container" {
  type        = string
  description = "Container for workload Terraform state"
}

###############################
# VM Configuration
###############################

variable "windows_vm_name" {
  type        = string
  default     = "winvm01"
}

variable "linux_vm_name" {
  type        = string
  default     = "linuxvm01"
}

variable "windows_vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
}

variable "linux_vm_size" {
  type        = string
  default     = "Standard_B2s"
}

variable "vm_os_disk_type" {
  type        = string
  default     = "Standard_LRS"
}

variable "vm_os_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

variable "admin_username" {
  type        = string
  default     = "localadmin"
}

variable "admin_password" {
  type        = string
  sensitive   = true
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
    owner       = "joshua"
  }
}
