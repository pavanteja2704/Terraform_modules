resource "google_compute_instance" "default" {
  name         = "my-cicd"
  machine_type = "e2-medium"
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

  metadata = {
    startup-script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install apache2 -y
    EOF
  }
}


