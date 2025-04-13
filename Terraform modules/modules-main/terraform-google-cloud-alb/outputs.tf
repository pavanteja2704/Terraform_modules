#...................................................... URL Map ......................................................#

output "URL_Map_Details" {
  value       = google_compute_url_map.default
  description = "Google Cloud Compute Url Map Details"
}

#.................................................... Target Proxy ....................................................#

output "Target_HTTP_Proxy_Details" {
  value       = google_compute_target_http_proxy.default
  description = "Google Cloud Target HTTP Proxy Details"
}

output "Target_HTTPS_Proxy_Details" {
  value       = google_compute_target_https_proxy.default
  description = "Google Cloud Target HTTPS Proxy Details"
}

#................................................... Backend Service ...................................................#

output "Backend_Service_Details" {
  value       = google_compute_backend_service.backend
  description = "Google Cloud Backend Service Details"
}

#.................................................... Backend Bucket ...................................................#

output "Backend_Bucket_Details" {
  value       = google_compute_backend_bucket.backend
  description = "Google Cloud Backend Bucket Details"
}

#..................................................... LB Frontend  ....................................................#

output "LB_Frontend_Details" {
  value       = google_compute_global_forwarding_rule.frontend
  description = "Google Cloud Frontend Details"
}