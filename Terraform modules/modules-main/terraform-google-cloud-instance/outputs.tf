/* output "instance_details" {
  value       = google_compute_instance.default
  description = "Google Cloud Instance Details"
} */

output "instance_name" {
  value       = google_compute_instance.default.name
  description = "Google Cloud Instance name"
}
output "instance_machine_type" {
  value       = google_compute_instance.default.machine_type
  description = "Google Cloud Instance Machine Type"
}
output "project_id" {
  value       = google_compute_instance.default.project
  description = "Google Cloud project ID"
}
output "instance_self_link" {
  value       = google_compute_instance.default.self_link
  description = "The URI of the instance rule  being created"
}
output "instance_status" {
  value       = google_compute_instance.default.desired_status
  description = "The desired status of the VM being created"
}