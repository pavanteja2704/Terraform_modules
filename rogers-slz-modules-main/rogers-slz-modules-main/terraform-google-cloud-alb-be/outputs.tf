#................................................... Backend Service ...................................................#

output "Region_Backend_Service_Details" {
  value       = google_compute_region_backend_service.default
  description = "Google Cloud Region Backend Service Details"
}
output "Backend_Service_Details" {
  value       = google_compute_backend_service.default
  description = "Google Cloud Backend Service Details"
}

#.................................................... Backend Bucket ...................................................#

output "Backend_Bucket_Details" {
  value       = google_compute_backend_bucket.backend
  description = "Google Cloud Backend Bucket Details"
}