#.................................. Source Code Repository .................................#

resource "google_sourcerepo_repository" "repo" {
  name          = var.repo_name
  project       = var.project_id
}