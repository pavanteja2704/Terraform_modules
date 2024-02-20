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

    # Install Apache2
    sudo apt-get update
    sudo apt-get install apache2 -y

    # Start Apache2
    sudo systemctl start apache2

    # Check if Apache2 is running
    sudo systemctl status apache2 | grep "active (running)"

    # Open port 80 on the firewall
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

    # Save the firewall rules
    sudo iptables-save

    EOF
  }
 network_interface {
  network = "default"
  access_config {}
}
}

