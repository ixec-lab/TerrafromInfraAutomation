module "vnet" {
  source = "./vnet"
  location = var.location
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
}

module "private_subnet" {
  source = "./private_subnet"
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
  location = var.location
}


module "public_subnet" {
  source = "./public_subnet"
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
}

module "nat" {
  source = "./nat"
  resource_group_name = var.resource_group_name
  location = var.location
  Privatesubnet_id = module.private_subnet.Privatesubnet_id
}

module "load_balancer" {
  source = "./load_balancer"
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
  location = var.location
  vm_private_ip1 = var.vm_private_ip1
  vm_private_ip2 = var.vm_private_ip2
  publicsubnet_id = module.public_subnet.publicsubnet_id
}