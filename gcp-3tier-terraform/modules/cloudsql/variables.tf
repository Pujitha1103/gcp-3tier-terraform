variable "region" {
  description = "Region for Cloud SQL instance."
  type        = string
}

variable "network_id" {
  description = "VPC network ID for private IP."
  type        = string
}

variable "db_user" {
  description = "Database username."
  type        = string
  sensitive   = true
}

variable "db_pass" {
  description = "Database password."
  type        = string
  sensitive   = true
}
