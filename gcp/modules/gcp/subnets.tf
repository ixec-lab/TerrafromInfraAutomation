# public subnet 
resource "google_compute_subnetwork" "public_subnet" {
    name = "public-subnet-${count.index}"
    count = length(var.public_subnets_cidr)
    ip_cidr_range = element(var.public_subnets_cidr,count.index)
    network = google_compute_network.vpc.self_link
    region = var.region
}

# private subnet
resource "google_compute_subnetwork" "private_subnet" {
    name = "private-subnet-${count.index}"
    count = length(var.private_subnets_cidr)
    ip_cidr_range = element(var.private_subnets_cidr,count.index)
    network = google_compute_network.vpc.self_link
    region = var.region

    purpose = "PRIVATE"
}