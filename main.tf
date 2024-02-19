resource "google_compute_instance" "default" {
  name         = "my-cicd-1"
  machine_type = "e2-medium"
  zone         = "asia-south1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  metadata = {
    startup-script = <<-EOF
    #!/bin/bash
    # Install required packages
    sudo apt-get update
    sudo apt-get install -y apache2
    EOF
  }
 network_interface {
  network = "default"
  access_config {}
}
}
