#...................................................... URL Map ......................................................#

output "Regional_URL_Map_Details" {
  value       = google_compute_region_url_map.default
  description = "Google Cloud Compute Regional Url Map Details"
}

output "Global_URL_Map_Details" {
  value       = google_compute_url_map.default
  description = "Google Cloud Compute Url Map Details"
}