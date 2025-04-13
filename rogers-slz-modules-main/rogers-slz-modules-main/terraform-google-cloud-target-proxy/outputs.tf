#.................................................... Target Proxy ....................................................#

output "Target_HTTP_Proxy_Details" {
  value       = google_compute_target_http_proxy.default
  description = "Google Cloud Target HTTP Proxy Details"
}

output "Target_HTTPS_Proxy_Details" {
  value       = google_compute_target_https_proxy.default
  description = "Google Cloud Target HTTPS Proxy Details"
}