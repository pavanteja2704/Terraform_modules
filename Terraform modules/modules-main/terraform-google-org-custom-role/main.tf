resource "google_organization_iam_custom_role" "role" {
  role_id     = var.role_id
  org_id      = var.org_id
  title       = var.title
  permissions = var.permissions
  stage       = var.stage
  description = var.description
}