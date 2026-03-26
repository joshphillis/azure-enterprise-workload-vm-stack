resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.linux_vm_name}-nic"
  location            = local.workload_location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = local.workload_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = var.linux_vm_name
  resource_group_name   = azurerm_resource_group.vm_rg.name
  location              = local.workload_location
  size                  = var.linux_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.linux_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.linux_admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_os_disk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}