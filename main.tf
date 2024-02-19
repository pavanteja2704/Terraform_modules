resource "google_compute_instance" "default" {
  name         = "my-cicd"
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
    sudo apt-get update
    sudo apt-get install -y python3
    EOF
  }
 network_interface {
  network = "default"
  access_config {}
}
}

