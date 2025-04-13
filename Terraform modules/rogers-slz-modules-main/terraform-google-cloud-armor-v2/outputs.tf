output "Region_Security_Policy_Name" {
  value       = google_compute_region_security_policy.policy.0.name
  description = "an identifier for the resource"
}
output "Region_Security_Policy_Id" {
  value       = google_compute_region_security_policy.policy.0.id
  description = "an identifier for the resource"
}
output "Region_Security_Policy_Self_Link" {
  value       = google_compute_region_security_policy.policy.0.self_link
  description = "The URI of the created resource"
}


output "Security_Policy_Name" {
  value       = google_compute_security_policy.policy
  description = "an identifier for the resource"
}
output "Security_Policy_Id" {
  value       = google_compute_security_policy.policy
  description = "an identifier for the resource"
}
output "Security_Policy_Self_Link" {
  value       = google_compute_security_policy.policy
  description = "The URI of the created resource"
}