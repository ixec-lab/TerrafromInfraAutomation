module "vpc" {
  source = "./vpc"
  environment          = var.environment
  vpc_cidr = var.vpc_cidr
}

module "public_subnet" {
  source = "./public_subnet"
  environment          = var.environment
  vpc_id = module.vpc.vpc_id
  public_subnets_cidr = var.public_subnets_cidr
  availability_zones = var.availability_zones
}

module "private_subnet" {
  source = "./private_subnet"
  environment          = var.environment
  vpc_id = module.vpc.vpc_id
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones = var.availability_zones
}


module "gateway" {
  source = "./gateway"
  environment          = var.environment
  vpc_id = module.vpc.vpc_id
  public_route_table_id = module.public_subnet.public_route_table_id
}

module "nat" {
  source = "./nat"
  environment          = var.environment
  intenet_gateway_ig = module.gateway.intenet_gateway_ig
  public_subnet_id = module.public_subnet.public_subnet_id
  private_RT_id = module.private_subnet.private_RT_id
}

module "load_balancer" {
  source = "./load_balancer"
  environment          = var.environment
  vpc_id = module.vpc.vpc_id
  instance_count = var.instance_count
  public_subnet_id = module.public_subnet.public_subnet_id
  private_vm_id = var.private_vm_id
}
