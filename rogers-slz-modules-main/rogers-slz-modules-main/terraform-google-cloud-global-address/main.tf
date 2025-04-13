#...................................................... locals ..........................................................#

locals {
  project       = var.project_id
  address_type  = var.global_address_type
}

#................................................... Global Address .....................................................#

resource "google_compute_global_address" "default" {
  provider      = google-beta
  project       = local.project
  name          = var.global_address_name
  description   = var.global_address_description
  address_type  = local.address_type 
  purpose       = local.address_type == "EXTERNAL" ? null : var.global_address_purpose
  prefix_length = local.address_type == "EXTERNAL" ? null : var.global_address_prefix_length
  network       = local.address_type == "EXTERNAL" ? null : var.global_address_network
  labels        = var.labels
  address       = local.address_type == "EXTERNAL" ? null : var.global_address_ip
}