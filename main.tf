module "Networking" {
    source                 = "./modules/Networking"
    project_id             = "playground-s-11-51fc7346"
    region                 = "europe-west1"
    zone                   = "europe-west1-b"
    public_subnets_cidr    = ["192.168.1.0/24"]
    public_instance_count  = 1
    private_subnets_cidr   = ["192.168.2.0/24"]
    private_instance_count = 2
    disable_health_check   = false
}