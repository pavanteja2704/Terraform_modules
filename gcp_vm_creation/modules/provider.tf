terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.10.0"
    }
  }
}
 
provider "google" {
  project = "groovy-scarab-405905"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "json.json"
}