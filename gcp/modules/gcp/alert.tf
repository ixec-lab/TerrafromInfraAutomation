resource "google_monitoring_notification_channel" "email" {
  display_name = "Send email when condition fired"
  type = "email"
  labels = {
    email_address = "islem.meghnine06@gmail.com"
  }
}

resource "google_monitoring_alert_policy" "alert_policy0" {
  display_name = "Google Cloud HTTP/S Load Balancing Rule - Request count"
  combiner = "OR"

  conditions {
    display_name = "Google Cloud HTTP/S Load Balancing Rule - Request count"

    condition_threshold {
      filter = "metric.type=\"loadbalancing.googleapis.com/https/request_count\" resource.type=\"https_lb_rule\" " 
      duration = "60s"

      comparison = "COMPARISON_GT"
      threshold_value = 10

        aggregations {
            alignment_period = "300s"
            per_series_aligner = "ALIGN_SUM"
            #cross_series_reducer = "REDUCE_SUM"
      }
    }
  }

  notification_channels = [
      "${google_monitoring_notification_channel.email.id}",
  ]
}