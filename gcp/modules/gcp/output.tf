output "vpcName" {
  value = google_compute_network.vpc.name
}

output "privateSubnetLocalIp" {
  value = var.private_subnets_cidr.*
}

output "publicSubnetLocalIp" {
  value = var.public_subnets_cidr.*
}

output "privatVmLocalIp" {
  	value = google_compute_instance.private_vm.*.network_interface.0.network_ip
}

output "publicVmLocalIp" {
  	value = google_compute_instance.public_vm.*.network_interface.0.network_ip
}

# show external ip address of load balancer
output "load-balancer-ip-address" {
  value = google_compute_global_forwarding_rule.global_forwarding_rule.ip_address
}
