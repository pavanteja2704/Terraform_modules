/* output "allowed_org_policy_details" {
    value = google_organization_policy.org_policy_list_allow_values
}

output "denied_org_policy_details" {
    value = google_organization_policy.org_policy_list_deny_all
} */

output "org_policy_details" {
    value = google_organization_policy.policy
}