locals {
  host_project       = var.host_project_id
  service_project    = var.service_project_id
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  provider           = google-beta
  #for_each           = toset(local.service_project)
  #count              = length(local.service_project)
  #service_project    = each.key
  host_project       = local.host_project
  service_project    = local.service_project
}
