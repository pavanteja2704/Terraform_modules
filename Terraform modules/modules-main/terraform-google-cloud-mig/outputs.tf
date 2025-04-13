#............................................... Instance Template ..............................................#

output "Instance_Template_Name" {
  value       = google_compute_instance_template.default.name
  description = "Google Cloud Instance Template name"
}
output "Instance_Template_ID" {
  value       = google_compute_instance_template.default.id
  description = "The ID of the Instance Template being created"
}
output "Instance_Template_Project_Id" {
  value       = google_compute_instance_template.default.project
  description = "Google Cloud Instance Template project ID"
}
output "Instance_Template_Self_Link" {
  value       = google_compute_instance_template.default.self_link
  description = "The URI of the Instance Template being created"
}

#.................................................. Health Check ................................................#

output "Health_Check_Name" {
  value       = google_compute_region_health_check.healthcheck.name
  description = "Google Cloud Compute Health Check Name"
}
output "Health_Check_ID" {
  value       = google_compute_region_health_check.healthcheck.id
  description = "Google Cloud Compute Health Check ID"
}
output "Health_Check_Self_Link" {
  value       = google_compute_region_health_check.healthcheck.self_link
  description = "Google Cloud Compute Health Check Self Link"
}

#...................................................... MIG .....................................................#

output "MIG_Name" {
  value       = google_compute_instance_group_manager.mig.name
  description = "Google Cloud MIG Name"
}
output "MIG_ID" {
  value       = google_compute_instance_group_manager.mig.id
  description = "Google Cloud MIG ID"
}
output "MIG_Self_Link" {
  value       = google_compute_instance_group_manager.mig.self_link
  description = "Google Cloud MIG Self Link"
}

#................................................... Autoscaler .................................................#

output "Autoscaler_Name" {
  value       = google_compute_autoscaler.autoscaler.*.name
  description = "Google Cloud Autoscaler Name"
}
output "Autoscaler_ID" {
  value       = google_compute_autoscaler.autoscaler.*.id
  description = "Google Cloud Autoscaler ID"
}
output "Autoscaler_Self_Link" {
  value       = google_compute_autoscaler.autoscaler.*.self_link
  description = "Google Cloud Autoscaler Self Link"
}