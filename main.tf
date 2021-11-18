terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }

  backend "gcs" {
    bucket = "idata2502-port-1-tko"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-idata2502-port-tko"
}

resource "google_compute_instance" "frontend" {
  name                    = "terraform-frontend-instance"
  machine_type            = "f1-micro"
  tags                    = ["frontend", "dev"]
  metadata_startup_script = file("./install-scripts/frontend.sh") 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "backend" {
  name                    = "terraform-backend-instance"
  machine_type            = "f1-micro"
  tags                    = ["backend", "dev"]
  metadata_startup_script = file("./install-scripts/backend.sh") 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "db" {
  name                    = "terraform-db-instance"
  machine_type            = "f1-micro"
  tags                    = ["db", "dev"]
  metadata_startup_script = file("./install-scripts/db.sh") 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "web-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["frontend", "backend", "db"]
}
