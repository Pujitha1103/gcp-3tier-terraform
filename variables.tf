# Input validation and best practices
variable "project_id" {
  description = "GCP Project ID"
  type        = string
  nullable    = false
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-south1"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]+$", var.region))
    error_message = "Region must be in the format 'xx-xxxxn'."
  }
}

variable "zone" {
  description = "Primary Zone"
  type        = string
  default     = "asia-south1-a"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]+-[a-z]$", var.zone))
    error_message = "Zone must be in the format 'xx-xxxxn-x'."
  }
}

variable "db-user-v2" {
  description = "Database username"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "db-pass-v2" {
  description = "Database password"
  type        = string
  sensitive   = true
  nullable    = false
}