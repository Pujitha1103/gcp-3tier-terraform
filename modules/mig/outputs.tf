output "instance_group" {
  description = "The managed instance group resource."
  value       = google_compute_instance_group_manager.mig.self_link
}
