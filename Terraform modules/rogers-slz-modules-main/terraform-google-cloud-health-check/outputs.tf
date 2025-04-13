#.................................................. HTTP Health Check .................................................#

output "HTTP_Health_Check_Name" {
  value       = google_compute_http_health_check.healthcheck[*].name
  description = "Google Cloud Compute HTTP Health Check Name"
}
output "Health_Check_ID" {
  value       = google_compute_http_health_check.healthcheck[*].id
  description = "Google Cloud Compute HTTP Health Check ID"
}
output "Health_Check_Self_Link" {
  value       = google_compute_http_health_check.healthcheck[*].self_link
  description = "Google Cloud Compute HTTP Health Check Self Link"
}


#.................................................. Region Health Check ................................................#

output "Region_Health_Check_Name" {
  value       = google_compute_region_health_check.healthcheck[*].name
  description = "Google Cloud Compute Region Health Check Name"
}
output "Region_Health_Check_ID" {
  value       = google_compute_region_health_check.healthcheck[*].id
  description = "Google Cloud Compute Region Health Check ID"
}
output "Region_Health_Check_Self_Link" {
  value       = google_compute_region_health_check.healthcheck[*].self_link
  description = "Google Cloud Compute Region Health Check Self Link"
}