resource "google_compute_instance_template" "app" {
  name_prefix  = "app-template"
  machine_type = "e2-medium"

  tags = ["web", "app"]

  network_interface {
    subnetwork = var.private_subnet
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y nginx
    systemctl start nginx
  EOF
}

resource "google_compute_instance_group_manager" "mig" {
  name               = "app-mig"
  base_instance_name = "app"
  zone               = var.zone
  version {
    instance_template = google_compute_instance_template.app.id
  }
  target_size = 2
}

resource "google_compute_autoscaler" "autoscaler" {
  name   = "app-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.mig.id

  autoscaling_policy {
    max_replicas = 4
    min_replicas = 2

    cpu_utilization {
      target = 0.6
    }
  }
}