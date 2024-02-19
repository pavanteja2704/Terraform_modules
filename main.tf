resource "google_compute_instance" "default" {
  name         = "my-cicd"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }

  metadata={
    startup-script = <<-EOF
    sudo apt-get update
    sudo apt-get install -y apache2
    EOF
  }
}


