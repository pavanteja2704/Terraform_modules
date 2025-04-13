resource "google_project_iam_custom_role" "role" {
  role_id     = var.role_id
  project     = var.project_id
  title       = var.title
  permissions = var.permissions
  stage       = var.stage
  description = var.description
}