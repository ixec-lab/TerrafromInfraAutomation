output "Lb-ip" {
  value = azurerm_public_ip.LB-ip.ip_address
}

output "Lb-id" {
  value = azurerm_application_gateway.network.id
}