output "instance_name" {
  description = "Cloud SQL instance name."
  value       = google_sql_database_instance.db.name
}

output "instance_connection_name" {
  description = "Cloud SQL connection name."
  value       = google_sql_database_instance.db.connection_name
}
