#................................................. Target Pool ..................................................#

output "Target_Pool_Name" {
  value       = google_compute_target_pool.pool[*].name
  description = "Google Cloud Target Pool Name"
}
output "Target_Pool_ID" {
  value       = google_compute_target_pool.pool[*].id
  description = "Google Cloud Target Pool ID"
}
output "Target_Pool_Self_Link" {
  value       = google_compute_target_pool.pool[*].self_link
  description = "Google Cloud Target Pool Self Link"
}

#.................................................... Backend ....................................................#

output "Backend_Service_Name" {
  value       = google_compute_region_backend_service.backend[*].name
  description = "Google Cloud Backend Service Name"
}
output "Backend_Service_ID" {
  value       = google_compute_region_backend_service.backend[*].id
  description = "Google Cloud Backend Service ID"
}
output "Backend_Service_Self_Link" {
  value       = google_compute_region_backend_service.backend[*].self_link
  description = "Google Cloud Backend Service Self Link"
}

#................................................... Frontend ....................................................#

output "Forwarding_Rule_Name" {
  value       = google_compute_forwarding_rule.rule.name
  description = "Google Cloud Forwarding Rule Name"
}
output "Forwarding_Rule_ID" {
  value       = google_compute_forwarding_rule.rule.id
  description = "Google Cloud Forwarding Rule ID"
}
output "Forwarding_Rule_Self_Link" {
  value       = google_compute_forwarding_rule.rule.self_link
  description = "Google Cloud Forwarding Rule Self Link"
}