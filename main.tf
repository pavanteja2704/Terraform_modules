resource "google_compute_instance" "default" {
  name         = "terraform-instance2"
  machine_type = "e2-medium"
  zone         = "asia-south1-b"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
  }
  metadata = {
    startup-script = <<-EOF
    #!/bin/bash
 
    # Install required packages
    sudo yum install tomcat git wget mysql -y
    EOF
  }
}
 
resource "google_compute_network" "default" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = false
}
 
resource "google_compute_subnetwork" "default" {
  name          = "subnet1"
  ip_cidr_range = "10.0.2.0/24"
  region        = "asia-south1"
  network       = google_compute_network.default.id
}
 
resource "google_compute_firewall" "default" {
  name          = "iap-access-firewall"
  network       = google_compute_network.default.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
 
#create a router
resource "google_compute_router" "default" {
  name    = "nat-router"
  network = google_compute_network.default.id
  region  = "asia-south1"
}
 
#attach nat to above vpc network
 resource "google_compute_router_nat" "default" {
  name          = "nat-gateway"
  region        = "asia-south1"
  router        = google_compute_router.default.name
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}