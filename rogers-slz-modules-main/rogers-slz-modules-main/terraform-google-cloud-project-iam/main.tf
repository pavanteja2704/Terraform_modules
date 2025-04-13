/******************************************
  Google Cloud Project IAM Policy
 *****************************************/
resource "google_project_iam_binding" "project_iam" {
  for_each  = toset(var.roles)
  project   = var.project_id
  #count     = length(var.roles)
  role      = each.key
  members   = var.members
}