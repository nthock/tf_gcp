provider "google" {
  project     = "staging-265722"
  region      = "asia-southeast1"
}

variable "boot_image_name" {
  type = string
  default= "cos-cloud/cos-stable"
}

variable "port_number" {
  type    = string
  default = "80"
}

variable "random_name" {
  type = string
}

data "google_compute_network" "default" {
  name = "default"
}

data "template_file" "startup_script_config" {
  template = file("startup.sh")
  vars = {
    random_name = var.random_name
  }
}

resource "google_compute_firewall" "http-80" {
  name    = "http-80"
  network = data.google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = [var.port_number]
  }
}

resource "google_compute_instance" "default" {
  name         = "default"
  machine_type = "g1-small"
  zone         = "asia-southeast1-a"
  tags         = ["docker-node"]

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

    service_account {
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = data.template_file.startup_script_config.rendered
}


output "Public_IP_Address" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}