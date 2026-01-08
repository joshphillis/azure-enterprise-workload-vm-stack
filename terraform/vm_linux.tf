resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = var.linux_vm_name
  resource_group_name   = local.workload_rg_name
  location              = local.workload_location
  size                  = var.linux_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.linux_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
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

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = var.tags
}