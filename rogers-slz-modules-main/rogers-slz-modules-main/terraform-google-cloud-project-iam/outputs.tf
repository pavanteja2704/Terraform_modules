/* output "project_iam_binding_details" {
    value = google_project_iam_binding.project_iam
} */
output "project_iam_roles" {
    value = google_project_iam_binding.project_iam[*].role
}
output "project_iam_members" {
    value = google_project_iam_binding.project_iam[*].members
}

