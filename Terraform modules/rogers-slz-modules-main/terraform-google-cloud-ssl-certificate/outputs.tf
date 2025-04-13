#.................................................... SSL Certificate ...................................................#

output "SSL_Certificate_Name" {
  value       = google_compute_ssl_certificate.default
  description = "Google Cloud SSL Certificate Name"
}

output "SSL_Certificate_ID" {
  value       = google_compute_ssl_certificate.default
  description = "Google Cloud SSL Certificate ID"
}

output "SSL_Certificate_Self_Link" {
  value       = google_compute_ssl_certificate.default
  description = "Google Cloud SSL Certificate Self_Link"
}



output "Regional_SSL_Certificate_Name" {
  value       = google_compute_region_ssl_certificate.default.0.name
  description = "Google Cloud Regional SSL Certificate Name"
}

output "Regional_SSL_Certificate_ID" {
  value       = google_compute_region_ssl_certificate.default.0.id
  description = "Google Cloud Regional SSL Certificate ID"
}

output "Regional_SSL_Certificate_Self_Link" {
  value       = google_compute_region_ssl_certificate.default.0.self_link
  description = "Google Cloud Regional SSL Certificate Self_Link"
}


output "Managed_SSL_Certificate_Details" {
  value       = google_compute_managed_ssl_certificate.default
  description = "Google Cloud Managed SSL Certificate Details"
}