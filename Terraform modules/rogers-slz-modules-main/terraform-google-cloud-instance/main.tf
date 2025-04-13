resource "google_compute_instance" "default" {
  project                           = var.project_id
  zone                              = var.zone
  name                              = var.name
  tags                              = var.tags
  labels                            = var.labels
  metadata                          = var.metadata
  machine_type                      = var.machine_type
  deletion_protection               = var.deletion_protection
  
  boot_disk {
    initialize_params {
      image                         = var.image
      size                          = var.size
      type                          = var.type
      labels                        = var.labels
    }
  }
  

  dynamic "attached_disk" {
    for_each                        = var.attached_disk
    content {
      source                        = attached_disk.value.source
    }
  }

  can_ip_forward                    = var.can_ip_forward
  desired_status                    = var.desired_status
  allow_stopping_for_update         = var.allow_stopping_for_update

  dynamic "network_interface" {
    for_each                        = var.network_interfaces
    content {
      subnetwork                    = network_interface.value.subnetwork
      network_ip                    = network_interface.value.network_ip
      nic_type                      = network_interface.value.nic_type
      dynamic "access_config" {
        for_each                    = lookup(network_interface.value, "access_config", [])
        content {
          nat_ip                    = access_config.value.nat_ip
        }
      }
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email                           = var.service_account_email
    scopes                          = var.service_account_scopes
  }

  scheduling {
    preemptible                     = var.preemptible
    automatic_restart               = var.automatic_restart
  }

  /* lifecycle {
    ignore_changes = [boot_disk.0.initialize_params.0.image, metadata]
  } */
}