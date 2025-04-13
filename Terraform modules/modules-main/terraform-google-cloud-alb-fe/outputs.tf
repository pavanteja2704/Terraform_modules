#..................................................... LB Frontend  ....................................................#

output "Regional_LB_Frontend_Details" {
  value       = google_compute_forwarding_rule.frontend
  description = "Google Cloud Frontend Details"
}

output "Global_LB_Frontend_Details" {
  value       = google_compute_global_forwarding_rule.frontend
  description = "Google Cloud Frontend Details"
}