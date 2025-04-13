locals {
  project_id           = var.monitoring_project
  metric_scopes        = var.monitored_project
}

resource "google_monitoring_monitored_project" "project" {
  provider        = google-beta
  for_each        = local.metric_scopes
  name            = each.key
  metrics_scope   = join("", ["locations/global/metricsScopes/", local.project_id])

  timeouts {
    create        = "2m"
    delete        = "3m"
  }
}