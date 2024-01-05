resource "google_compute_instance" "vm-for-terraform-1" {
  name         = "vm-test-12"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = "default"
  }

 metadata_startup_script = "echo hi > /test.txt"
 # allow_stopping_for_update = true
}


