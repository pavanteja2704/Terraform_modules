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
    apt-get update
    apt-get install nginx -y
    apt-get install apache2 -y
    EOF
  }
 network_interface {
  network = "default"
  access_config {}
}
}
resource "google_compute_firewall" "allow-http" {
   name = "allow-http" 
   network = "default" 
allow { 
  protocol = "tcp"
  ports = ["80"]
} 
source_ranges = ["0.0.0.0/0"] 
}
