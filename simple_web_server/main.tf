provider "google" {
  credentials = file("../gcp_credentials.json")
  project = "staging-265722"
  region = "asia-southeast1"
}

variable "boot_image_name" {
  type = string
  default= "debian-9-stretch-v20200204"
}

variable "port_number" {
  type = string
  default = "80"
}

data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_firewall" "http-80" {
  name = "http-80"
  network = data.google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [var.port_number]
  }
}

resource "google_compute_instance" "default" {
  name = "default"
  machine_type = "g1-small"
  zone = "asia-southeast1-a"

  boot_disk {
    auto_delete = true
    initialize_params {
      image = var.boot_image_name
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("startup.sh")
}


output "Public_IP_Address" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}