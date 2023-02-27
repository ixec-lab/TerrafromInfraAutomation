module "networking" {
  source               = "./modules/networking"
  region               = "us-east-1"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24"]
  private_subnets_cidr = ["10.0.2.0/24"]
  availability_zones   = ["us-east-1b"]
  private_vm_id = module.compute.private_vm_id  
  instance_count = var.instance_count
}

module "compute" {
  source = "./modules/compute"
  environment          = "dev"
  vpc_id = module.networking.vpc_id
  instance_count = var.instance_count
  private_subnet_id = module.networking.private_subnet_id
}

module "monitoring" {
  source = "./modules/monitoring"
  target_group_arn_suffix = module.networking.target_group_arn_suffix
  load_balancer_arn_suffix = module.networking.load_balancer_arn_suffix
}