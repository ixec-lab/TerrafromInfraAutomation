### gcp outputs ###

output "vpcName" {
  value = module.gcp.vpcName
}

output "privateSubnetLocalIp" {
  value = module.gcp.privateSubnetLocalIp
}

output "publicSubnetLocalIp" {
  value = module.gcp.publicSubnetLocalIp
}

output "privatVmLocalIp" {
  value = module.gcp.privatVmLocalIp
}

output "publicVmLocalIp" {
  value = module.gcp.publicVmLocalIp
}

# show external ip address of load balancer
output "load-balancer-ip-address" {
  value = module.gcp.load-balancer-ip-address
}