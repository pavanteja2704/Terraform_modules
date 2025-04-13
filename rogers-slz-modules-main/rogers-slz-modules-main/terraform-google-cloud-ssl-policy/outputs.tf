output "ssl_policy_name" {
    value = google_compute_ssl_policy.policy
    description = "Global SSL Policy Name" 
}
output "ssl_policy_id" {
    value = google_compute_ssl_policy.policy
    description = "Global SSL Policy ID" 
}
output "region_ssl_policy_name" {
    value = google_compute_region_ssl_policy.policy.0.name
    description = "Regional SSL Policy Name" 
}
output "region_ssl_policy_id" {
    value = google_compute_region_ssl_policy.policy.0.id
    description = "Regional SSL Policy ID" 
}