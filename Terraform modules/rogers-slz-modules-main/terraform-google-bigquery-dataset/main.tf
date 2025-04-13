resource "google_bigquery_dataset" "dataset" {
  project                     = var.project_id
  dataset_id                  = var.dataset_id
  friendly_name               = var.friendly_name
  description                 = var.description
  location                    = var.location
  labels                      = var.labels 

  dynamic "access" {
    for_each                  = var.access
    content {
      role                    = access.value.role
      group_by_email          = access.value.group_by_email
      user_by_email           = access.value.user_by_email
      special_group           = access.value.special_group
    }
  }
}