output "allow_http_id" {
  description = "The ID of the HTTP firewall rule."
  value       = google_compute_firewall.allow_http.id
}

output "allow_internal_id" {
  description = "The ID of the internal firewall rule."
  value       = google_compute_firewall.allow_internal.id
}
