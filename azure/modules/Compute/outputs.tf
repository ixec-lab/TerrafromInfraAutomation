output "vm_private_ip1" {
  value = azurerm_linux_virtual_machine.VM1.private_ip_address
}

output "vm_private_ip2" {
  value = azurerm_linux_virtual_machine.VM2.private_ip_address
}