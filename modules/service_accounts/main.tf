resource "google_service_account" "terraform" {
  account_id   = "terraform-deployer-v2"
  display_name = "Terraform Deployer Service Account V2"
}

# Assign required IAM roles to the service account
resource "google_project_iam_member" "terraform_secretmanager_admin" {
  project = var.project_id
  role    = "roles/secretmanager.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_compute_admin" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_project_iam_member" "terraform_network_admin" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

output "terraform_service_account_email" {
  value = google_service_account.terraform.email
}
