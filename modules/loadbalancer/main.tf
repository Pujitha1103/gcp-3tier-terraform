resource "google_compute_health_check" "default" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "default" {
  name        = "backend-service"
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}