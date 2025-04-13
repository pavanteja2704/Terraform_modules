resource "google_logging_project_sink" "sink" {
  name                          = var.name
  destination                   = var.destination
  filter                        = var.filter
  description                   = var.description
  disabled                      = var.disabled
  project                       = var.project_id
  unique_writer_identity        = var.unique_writer_identity
  custom_writer_identity        = var.custom_writer_identity
  include_children              = var.include_children

  dynamic "bigquery_options" {
    for_each                    = var.bigquery_options[*]
    content {
      use_partitioned_tables    = lookup(bigquery_options.value, "use_partitioned_tables", 100)
    }
  }

  dynamic "exclusions" {
    for_each                    = var.exclusions[*]
    content {
      name                      = lookup(exclusions.value, "name", "")
      description               = lookup(exclusions.value, "description", "")
      filter                    = lookup(exclusions.value, "filter", "")
      disabled                  = lookup(exclusions.value, "disabled", "")
    }
  }
}