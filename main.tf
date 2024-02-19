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
 
#code to create image of the above vm instance
resource "google_compute_image" "default" {
  name         = "terraform-image"
  source_disk = google_compute_instance.default.boot_disk.0.source
  family       = "terraform-image-family"
}
 
#code to create instance template using above image
resource "google_compute_instance_template" "default" {
  name = "terraform-instance-template"
  machine_type = "e2-medium"
  region = "asia-south1"
  disk {
    source_image = google_compute_image.default.self_link
    auto_delete = true
    boot = true
  }
  network_interface {
   network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
  }
}
 
#code to create manage multi zone instance group using above instance template
resource "google_compute_instance_group_manager" "default" {
  name = "weektwomig"
  version {
    instance_template = google_compute_instance_template.default.id
  }
  base_instance_name = "terraform-instance-group-manager"
  zone = "asia-south1-b"
  target_size =3
}
 
#configure auto scaling for above instance group
resource "google_compute_autoscaler" "default" {
  name   = "weektwoautoscaler"
  zone   = "asia-south1-b"
  target = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60
    cpu_utilization {
      target = 0.5
    }
  }
}