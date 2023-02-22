module "Networking" {
  source               = "./modules/networking"
  region               = "us-east-1"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24"]
  private_subnets_cidr = ["10.0.2.0/24"]
  availability_zones   = ["us-east-1b"]
  AWS_ACCESS_KEY       = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY       = var.AWS_SECRET_KEY
  instance_count       = 2
}