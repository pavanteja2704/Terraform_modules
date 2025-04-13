locals {
  host_project       = var.host_project_id
}

resource "google_compute_shared_vpc_host_project" "host_project" {
  #provider            = google-beta
  #count              = var.shared_vpc ? 1 : 0
  project            = local.host_project
}
