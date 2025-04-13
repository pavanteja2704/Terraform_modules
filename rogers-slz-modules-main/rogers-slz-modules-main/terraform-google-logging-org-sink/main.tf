resource "google_logging_organization_sink" "sink" {
  name                          = var.name
  org_id                        = var.org_id
  destination                   = var.destination
  filter                        = var.filter
  description                   = var.description
  disabled                      = var.disabled
  include_children              = var.include_children

  dynamic "bigquery_options" {
    for_each                    = var.bigquery_options != null ? var.bigquery_options[*] : []
    content {
      use_partitioned_tables    = lookup(bigquery_options.value, "use_partitioned_tables", null)
    }
  }

  dynamic "exclusions" {
    for_each                    = var.exclusions[*]
    content {
      name                      = lookup(exclusions.value, "name", null)
      description               = lookup(exclusions.value, "description", null)
      filter                    = lookup(exclusions.value, "filter", null)
      disabled                  = lookup(exclusions.value, "disabled", null)
    }
  }
}