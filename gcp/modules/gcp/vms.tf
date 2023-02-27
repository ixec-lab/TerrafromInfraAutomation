# private instances (server) located in private subnet
resource "google_compute_instance" "private_vm" {
    name = "private-vm-${count.index}"
    count = var.private_instance_count
    zone = var.zone
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        subnetwork = element(google_compute_subnetwork.private_subnet,count.index).self_link
    }

    metadata = {
        ssh-keys = "john:${file("./gcp/creds/id_rsa.pub")}"
    }

    metadata_startup_script = "${file("./gcp/scripts/install.sh")}"

    tags = [ "private-instances", "allow-lb-packets"] # TODO: allowing ONLY the lb to communicate with this private VMs
}

# public instances (server) located in public subnet
resource "google_compute_instance" "public_vm" {
    name = "public-vm-${count.index}"
    count = var.public_instance_count


    zone = var.zone
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        subnetwork = element(google_compute_subnetwork.public_subnet,count.index).self_link
        
        access_config {
            // empty block means ephemeral external IP
        }
    }

    metadata = {
        ssh-keys = "john:${file("./gcp/creds/id_rsa.pub")}"
    }


    tags = [ "public-instances" ]
}