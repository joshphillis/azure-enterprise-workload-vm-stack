resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = var.windows_vm_name
  resource_group_name   = local.workload_rg_name
  location              = local.workload_location
  size                  = var.windows_vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
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

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = var.tags
}