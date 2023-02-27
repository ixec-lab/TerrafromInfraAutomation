# Internal firewall to allow local ssh and ICMP to test connectivity between machines
resource "google_compute_firewall" "internal_firewall" {
    name = "internal-firewall-${google_compute_network.vpc.name}"
    network = google_compute_network.vpc.self_link
    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports = [ "22" ]
    }

    allow {
        protocol = "tcp"
        ports = [ "80" ]
    }

    allow {
        protocol = "udp"
        ports = [ "0-65535" ]
    }

    source_ranges = [
        "${var.private_subnets_cidr[0]}",
        "${var.public_subnets_cidr[0]}"
        ]
    target_tags = ["private-instances"]
}

# allow ssh connection from outside
resource "google_compute_firewall" "external_firewall" {
    name = "external-firewall-${google_compute_network.vpc.name}"
    network = google_compute_network.vpc.self_link

    allow {
        protocol = "tcp"
        ports = [ "22" ]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["public-instances"]
    
}

# firewall rule allowing access to private subnet via port 80
resource "google_compute_firewall" "default-lb-fw" {
  name    = "auth-packets-lb"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags   = ["allow-lb-packets"]
}