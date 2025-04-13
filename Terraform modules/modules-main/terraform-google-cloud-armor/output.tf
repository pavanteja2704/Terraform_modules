output "security_policy_id" {
  value       = google_compute_security_policy.policy.id
  description = "an identifier for the resource"
}

output "security_policy_self_link" {
  value       = google_compute_security_policy.policy.self_link
  description = "The URI of the created resource"
}
