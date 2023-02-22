# provider for google with auth settings
provider "google"{
    credentials = "${file("./creds/login.json")}"
    project = var.project_id
    region  = var.region
    zone    = var.zone
}