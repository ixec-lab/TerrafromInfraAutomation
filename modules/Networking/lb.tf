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