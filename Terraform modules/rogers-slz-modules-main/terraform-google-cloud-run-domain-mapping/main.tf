resource "google_cloud_run_domain_mapping" "domain_map" {
  for_each = toset(var.verified_domain_name)
  provider = google-beta
  location = google_cloud_run_service.main.location
  name     = each.value
  project  = google_cloud_run_service.main.project

  metadata {
    labels      = var.domain_map_labels
    annotations = var.domain_map_annotations
    namespace   = var.project_id
  }

  spec {
    route_name       = google_cloud_run_service.main.name
    force_override   = var.force_override
    certificate_mode = var.certificate_mode
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["run.googleapis.com/operation-id"],
    ]
  }
}