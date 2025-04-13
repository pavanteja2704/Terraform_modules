terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.10.0"
    }
  }
}
 
provider "google" {
  project = "hardy-binder-411706"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "json.json"
}