############################################
# Backend State (Workload)
############################################
workload_state_rg        = "tfstate-rg"
workload_state_sa        = "tfstateaccount123"
workload_state_container = "tfstate"
workload_state_key       = "workload-vm-stack.tfstate"


############################################
# VM Credentials
############################################
# Consistent admin username for Linux + Windows
admin_username = "localadmin"

# Paste your SSH PUBLIC key here (from azurevm.pub or whatever filename you chose)
linux_admin_ssh_public_key = "ssh-rsa AAAA...paste-your-key-here...=="

# Strong Windows password you control
windows_admin_password = "YourStrongPasswordHere!"


############################################
# VM Names and Sizes
############################################
linux_vm_name   = "linuxvm01"
windows_vm_name = "winvm01"

linux_vm_size   = "Standard_B2s"
windows_vm_size = "Standard_B2s"

vm_os_disk_type = "Standard_LRS"


############################################
# Networking (Workload VNet)
############################################
workload_vnet_cidr   = "10.1.0.0/16"
workload_subnet_cidr = "10.1.0.0/24"


############################################
# Hub Values (Paste from Landing Zone Outputs)
############################################
hub_vnet_id   = "<paste-from-landingzone-output>"
hub_vnet_name = "<paste-from-landingzone-output>"
