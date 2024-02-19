resource "google_compute_instance" "default" {
  name         = "terraform-instance2"
  machine_type = "e2-medium"
  zone         = "asia-south1-b"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  metadata = {
    startup-script = <<-EOF
    #!/bin/bash
 
    # Install required packages
    sudo yum install tomcat git wget mysql -y
    EOF
  }
 network_interface {
  network = "default"
  access_config {}
}
}
