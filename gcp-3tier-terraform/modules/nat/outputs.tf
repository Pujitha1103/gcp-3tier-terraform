output "router_name" {
  description = "The name of the NAT router."
  value       = google_compute_router.router.name
}

output "nat_name" {
  description = "The name of the NAT resource."
  value       = google_compute_router_nat.nat.name
}
