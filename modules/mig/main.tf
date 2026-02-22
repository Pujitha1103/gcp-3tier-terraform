resource "google_compute_instance_template" "app" {
  name_prefix  = "app-template-v2-"
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

  disk {
    auto_delete  = true
    boot         = true
    source_image = "projects/debian-cloud/global/images/family/debian-11"
    disk_type    = "pd-balanced"
    disk_size_gb = 10
  }
}

resource "google_compute_instance_group_manager" "mig" {
  name               = "app-mig-v2"
  base_instance_name = "app-v2"
  zone               = var.zone
  version {
    instance_template = google_compute_instance_template.app.id
  }
  target_size = 2
}

resource "google_compute_autoscaler" "autoscaler" {
  name   = "app-autoscaler-v2"
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