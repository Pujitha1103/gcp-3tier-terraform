resource "google_sql_database_instance" "db" {
  name             = "prod-sql"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-custom-1-3840"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_id
    }
  }
}

resource "random_password" "db_pass" {
  length  = 16
  special = true
}

resource "google_secret_manager_secret" "db_user" {
  secret_id = "db-user"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_user_version" {
  secret      = google_secret_manager_secret.db_user.id
  secret_data = var.db_user
}

resource "google_secret_manager_secret" "db_pass" {
  secret_id = "db-pass"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_pass_version" {
  secret      = google_secret_manager_secret.db_pass.id
  secret_data = random_password.db_pass.result
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.db.name
  password = random_password.db_pass.result
}