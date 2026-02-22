output "instance_name_20260222" {
  description = "Cloud SQL instance name."
  value       = google_sql_database_instance.db_20260222.name
}

output "instance_connection_name_20260222" {
  description = "Cloud SQL connection name."
  value       = google_sql_database_instance.db_20260222.connection_name
}
