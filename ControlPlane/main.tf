resource "google_compute_network" "vpc" {
  name                    = "bindplane-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow_bindplane" {
  name    = "allow-bindplane"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3001", "4320"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "control_plane" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    network = google_compute_network.vpc.name
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup/controlplane.sh")

  tags = ["bindplane"]
}
