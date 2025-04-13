#................................................. UMIG ..................................................#

output "UMIG_Details" {
  value       = google_compute_instance_group.umig
  description = "Google Cloud UMIG Details"
}