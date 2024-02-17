resource "google_compute_instance" "default" {
  name         = "my-cicd"
  machine_type = "n2-standard-2"
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

    access_config {
       // Ephemeral public IP
    }
  }
 metadata = {
    foo = "bar"
  }
  metadata_startup_script = "echo hi > /test.txt"
}




