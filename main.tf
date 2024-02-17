resource "google_compute_instance" "default" {
  name         = "my-cicd"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  
  metadata_startup_script = <<-EOF
    apt-get update
    apt-get install -y apache2
    EOF
  
  network_interface {
    network = "default"
    access_config {}
  }
}




