output "Region_Security_Policy_Rule_Id" {
  value       = google_compute_region_security_policy_rule.rule.0.id
  description = "an identifier for the resource"
}

/* output "Security_Policy_Rule_Id" {
  value       = google_compute_security_policy.policy.0.id
  description = "an identifier for the resource"
} */