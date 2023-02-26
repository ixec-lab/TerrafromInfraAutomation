#Prints the Load balancer ip
output "Loadbalancer_ip" {
  description = "IP of the LB"
  value       = azurerm_public_ip.LB-ip.ip_address
}




