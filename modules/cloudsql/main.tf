resource "google_sql_database_instance" "db_20260222" {
  name             = "prod-sql-v2"
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

resource "random_password" "db-pass-v2" {
  length  = 16
  special = true
}

resource "google_secret_manager_secret" "db-user-v2" {
  secret_id = "db-user-v2"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_user_version_20260222" {
  secret      = google_secret_manager_secret.db-user-v2.id
  secret_data = var.db-user-v2
}

resource "google_secret_manager_secret" "db-pass-v2" {
  secret_id = "db-pass-v2"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_pass_version_20260222" {
  secret      = google_secret_manager_secret.db-pass-v2.id
  secret_data = random_password.db-pass-v2.result
}

resource "google_sql_user" "users_20260222" {
  name     = var.db-user-v2
  instance = google_sql_database_instance.db_20260222.name
  password = random_password.db-pass-v2.result
}