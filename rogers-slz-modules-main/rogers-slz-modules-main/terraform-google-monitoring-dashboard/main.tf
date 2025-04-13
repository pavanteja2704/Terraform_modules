resource "google_monitoring_dashboard" "dashboard" {
  dashboard_json    = var.dashboard_json
  project           = var.project_id

  lifecycle {
    ignore_changes  = [dashboard_json,]
  }
  
}