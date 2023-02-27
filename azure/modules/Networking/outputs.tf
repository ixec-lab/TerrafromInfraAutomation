output "vnet_name" {
  value = module.vnet.vnet_name
}

output "Privatesubnet_id" {
  value = module.private_subnet.Privatesubnet_id
  }

 output "Lb-ip" {
  value = module.load_balancer.Lb-ip
} 

output "Lb-id" {
  value = module.load_balancer.Lb-id
}