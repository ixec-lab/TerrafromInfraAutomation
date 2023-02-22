output "vpcName" {
  value = module.Networking.vpcName
}

output "privateSubnetLocalIp" {
  value = module.Networking.privateSubnetLocalIp
}

output "publicSubnetLocalIp" {
  value = module.Networking.publicSubnetLocalIp
}

output "privatVmLocalIp" {
  value = module.Networking.privatVmLocalIp
}

output "publicVmLocalIp" {
  value = module.Networking.publicVmLocalIp
}