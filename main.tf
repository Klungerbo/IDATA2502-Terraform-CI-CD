terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("../idata2502-portfolio-1-tko-e83f60880ce2.json")

  project = "idata2502-portfolio-1-tko"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}