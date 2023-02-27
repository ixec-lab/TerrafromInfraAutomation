/* 

# load balancer 

resource "google_compute_forwarding_rule" "forward_rule_nlb" {
  name                  = "forward-rule-nlb"
  target                = google_compute_target_pool.target_pool_nlb.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  region                = var.region
  ip_protocol           = "TCP"
  depends_on = [
    google_compute_target_pool.target_pool_nlb
  ]
}

# lb pool to define target server for balancing the payloads
resource "google_compute_target_pool" "target_pool_nlb" {
  name             = "target-pool-nlb"
  session_affinity = "NONE"
  #instances    = ["${var.zone}/${google_compute_instance.private_vm[0].name}","${var.zone}/${google_compute_instance.private_vm[1].name}"]
  instances     = [for vm in google_compute_instance.private_vm : "${var.zone}/${vm.name}"]
  health_checks = var.disable_health_check ? [] : [google_compute_http_health_check.health_check_nlb[0].self_link]
}

# health check

resource "google_compute_http_health_check" "health_check_nlb" {
  count   = var.disable_health_check ? 0 : 1
  name    = "public-healthcheck"

  check_interval_sec  = 5
  healthy_threshold   = 3
  timeout_sec         = 5
  unhealthy_threshold = 2

  port                = 80
  request_path        = "/"
} 
*/

# Load balancer with unmanaged instance group  used to forward traffic to the correct load balancer for HTTP load balancing
resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name = "${var.project_id}-global-forwarding-rule"
  target = google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "80"


}
# used by one or more global forwarding rule to route incoming HTTP requests to a URL map
resource "google_compute_target_http_proxy" "target_http_proxy" {
  name = "${var.project_id}-proxy"
  url_map = google_compute_url_map.url_map.self_link

}
# defines a group of virtual machines that will serve traffic for load balancing
resource "google_compute_backend_service" "backend_service" {
  name = "${var.project_id}-backend-service"
  port_name = "http"
  protocol = "HTTP"
  health_checks = ["${google_compute_health_check.healthcheck.self_link}"]

  backend {
    group = google_compute_instance_group.web_private_group.self_link
    balancing_mode = "RATE"
    max_rate_per_instance = 100
  }


}
# creates a group of dissimilar virtual machine instances
resource "google_compute_instance_group" "web_private_group" {
  name = "${var.project_id}-vm-group"
  description = "Web servers instance group"
  zone = var.zone
  instances = [
    google_compute_instance.private_vm[0].self_link,
    google_compute_instance.private_vm[1].self_link
  ]
  named_port {
    name = "http"
    port = "80"
  }


}
# determine whether instances are responsive and able to do work
resource "google_compute_health_check" "healthcheck" {
  name = "${var.project_id}-healthcheck"
  timeout_sec = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}
# used to route requests to a backend service based on rules that you define for the host and path of an incoming URL
resource "google_compute_url_map" "url_map" {
  name = "${var.project_id}-load-balancer"
  default_service = google_compute_backend_service.backend_service.self_link
}