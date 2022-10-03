terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.34.0"
    }
  }
}

provider "google" {
  credentials = file("application_default_credentials.json")
  project = "altenar-deliseev-0"
  region = "europe-central2"
  zone = "europe-central2-a"
}

resource "google_container_registry" "registry" {
  project  = "altenar-deliseev-0"
  location = "EU"
}

resource "google_container_cluster" "todo-app-cluster" {
  name               = "todo-app-cluster"
  location           = "europe-central2-a"
  initial_node_count = 1
  node_config {
    service_account = "terraform-agent@altenar-deliseev-0.iam.gserviceaccount.com"
    machine_type = "e2-small"
    labels = {
      foo = "main"
    }
    tags = ["main", "node"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
