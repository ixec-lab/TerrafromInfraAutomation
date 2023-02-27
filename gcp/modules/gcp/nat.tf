# create a public ip for nat service
resource "google_compute_address" "nat-ip" {
    name = "nat-ip"
    project = var.project_id
    region  = var.region
}

# creating router for NAT
resource "google_compute_router" "nat-router" {
    name = "nat-router"
    network = google_compute_network.vpc.name
}

# create a nat to allow private instances connect to internet
resource "google_compute_router_nat" "nat-gateway" {
  name = "nat-gateway"
  router = google_compute_router.nat-router.name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [ google_compute_address.nat-ip.self_link ]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork { 
     name = google_compute_subnetwork.private_subnet[0].id
     source_ip_ranges_to_nat = [var.private_subnets_cidr[0]] # "ALL_IP_RANGES_IN_ONE_PRIVATE_SUBNET"
  }
  depends_on = [ google_compute_address.nat-ip ]
}