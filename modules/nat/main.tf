resource "google_compute_router" "router" {
  name    = "nat-router-v2"
  region  = var.region
  network = var.network_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "cloud-nat-v2"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}