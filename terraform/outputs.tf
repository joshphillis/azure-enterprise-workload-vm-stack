output "windows_vm_private_ip" {
  value = azurerm_network_interface.windows_nic.private_ip_address
}

output "linux_vm_private_ip" {
  value = azurerm_network_interface.linux_nic.private_ip_address
}

output "windows_vm_name" {
  value = var.windows_vm_name
}

output "linux_vm_name" {
  value = var.linux_vm_name
}

output "private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
