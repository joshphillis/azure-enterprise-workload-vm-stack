#############################################
# Windows NIC
#############################################

resource "azurerm_network_interface" "windows_nic" {
  name                = "${var.windows_vm_name}-nic"
  location            = local.workload_location
  resource_group_name = local.workload_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.workload_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

#############################################
# Linux NIC
#############################################

resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.linux_vm_name}-nic"
  location            = local.workload_location
  resource_group_name = local.workload_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.workload_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}