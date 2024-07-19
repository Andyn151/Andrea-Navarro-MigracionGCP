terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.37.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "crypto-truck-428120-d4"
  region = "europe-southwest1"
  zone = "europe-southwest1-a"
  credentials = file("cred.json")
}

resource "google_compute_network" "mired" {
  name= "nuevared"
}

resource "google_compute_address" "miip" {
  name = "static-ip"
}

resource "random_string" "random" {
  length = 9
  special = false
  upper = false  
}

resource "google_storage_bucket" "mibucket" {
  name = "mibucket-${random_string.random.result}"
  location = "EU"
}

# main.tf

resource "google_compute_instance" "vm_instance" {
  name         = "mi-instancia-vm"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20220630"  # Ejemplo de una imagen específica de Ubuntu 20.04
    }
  }

  network_interface {
    network = google_compute_network.mired.self_link
    access_config {
      // Configuración de acceso
    }
  }
}

