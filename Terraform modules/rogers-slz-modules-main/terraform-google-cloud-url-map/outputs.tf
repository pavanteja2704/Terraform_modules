#....................................................... URL Map ........................................................#

output "URL_Map_Details" {
  value       = google_compute_url_map.default
  description = "Google Cloud Compute Url Map Details"
}