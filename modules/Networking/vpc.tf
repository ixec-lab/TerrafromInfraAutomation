# virtual private cloud network
resource "google_compute_network" "vpc" {
    name = "simple-vpc"
    auto_create_subnetworks = false
}
