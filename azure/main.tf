
module "Networking" {
  source = "./modules/Networking"
  location = var.location
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
  vm_private_ip1 = module.Compute.vm_private_ip1
  vm_private_ip2 = module.Compute.vm_private_ip2
}

module "Compute" {
  source = "./modules/Compute"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = module.Networking.Privatesubnet_id
  vm1_name = var.vm1_name
  vm2_name = var.vm2_name
}

module "Monitoring" {
  source = "./modules/Monitoring"
  resource_group_name = var.resource_group_name
  Lb-id = module.Networking.Lb-id
}
