output "Firewall_Rule_Details" {
  value       = google_compute_firewall.rules
  description = "The created firewall rule resources"
}