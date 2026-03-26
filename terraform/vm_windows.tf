resource "azurerm_network_interface" "windows_nic" {
  name                = "${var.windows_vm_name}-nic"
  location            = local.workload_location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = local.workload_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = var.windows_vm_name
  resource_group_name   = azurerm_resource_group.vm_rg.name
  location              = local.workload_location
  size                  = var.windows_vm_size
  admin_username        = var.admin_username
  admin_password        = var.windows_admin_password
  network_interface_ids = [azurerm_network_interface.windows_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_os_disk_type
  }

  source_image_reference {
    publisher = var.vm_os_image.publisher
    offer     = var.vm_os_image.offer
    sku       = var.vm_os_image.sku
    version   = var.vm_os_image.version
  }

  tags = var.tags
}