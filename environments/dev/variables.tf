variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "Primary Zone"
  type        = string
}

variable "db-user-v2" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db-pass-v2" {
  description = "Database password"
  type        = string
  sensitive   = true
}
