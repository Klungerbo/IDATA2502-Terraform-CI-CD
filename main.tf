terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

resource "google_storage_bucket" "gcs_bucket" {
  name = "terraform-bucket-idata2502-port-tko"
}

provider "google" {
  project = "idata2502-portfolio-1-tko"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-idata2502-port-tko"
}
