resource "google_logging_folder_sink" "sink" {
  name                          = var.name
  folder                        = var.folder_id
  destination                   = var.destination
  filter                        = var.filter
  description                   = var.description
  disabled                      = var.disabled
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