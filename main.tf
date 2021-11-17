terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
  backend "gcs" {
    bucket  = "idata2502-port-1-tko"
    prefix  = "terraform/state"
  }
}

resource "google_storage_bucket" "bucket1" {
  name = "idata2502-port-1-tko"
}

provider "google" {
  #credentials = file("../idata2502-portfolio-1-tko-f20b96d955de.json")
  project = "idata2502-portfolio-1-tko"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-idata2502-port-tko"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

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
