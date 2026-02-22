resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_tags = ["app"]
  target_tags = ["db"]
}