variable "name" {
  description                 = "(Required) The name of the logging sink."
  type                        = string
}
variable "destination" {
  description = "(Required) The destination of the sink (or, in other words, where logs are written to). Can be a Cloud Storage bucket, a PubSub topic, a BigQuery dataset, a Cloud Logging bucket, or a Google Cloud project"
  type                        = string
}
variable "filter" {
  description                 = "(Optional) The filter to apply when exporting logs. Only log entries that match the filter are exported."
  type                        = string
}
variable "description" {
  description                 = "(Optional) A description of this sink. The maximum length of the description is 8000 characters."
  type                        = string
}
variable "disabled" {
  description                 = "(Optional) If set to True, then this sink is disabled and it does not export any log entries."
  type                        = string
}
variable "project_id" {
  description                 = "(Optional) The ID of the project to create the sink in."
  type                        = string
}
variable "unique_writer_identity" {
  description                 = "(Optional) Whether or not to create a unique identity associated with this sink. If false, then the writer_identity used is serviceAccount:cloud-logs@system.gserviceaccount.com. If true (the default), then a unique service account is created and used for this sink. If you wish to publish logs across projects or utilize bigquery_options, you must set unique_writer_identity to true."
  type                        = string
}
variable "custom_writer_identity" {
  description                 = " (Optional) A user managed service account that will be used to write the log entries. The format must be serviceAccount:some@email. This field can only be specified if you are routing logs to a destination outside this sink's project. If not specified, a Logging service account will automatically be generated."
  type                        = string
}
variable "include_children" {
  description = "(Optional) Whether or not to include children folders in the sink export. If true, logs associated with child projects are also exported; otherwise only logs relating to the provided folder are included."
  type                        = bool
  default                     = true
}
variable "bigquery_options" {
  description = "(Optional) Options that affect sinks exporting data to BigQuery."
  type = object({
    use_partitioned_tables    = bool
  })
  default                     = [
    {
      use_partitioned_tables  = bool
    }
  ]
}
variable "exclusions" {
  description                 = "(Optional) Log entries that match any of the exclusion filters will not be exported. If a log entry is matched by both filter and one of exclusions.filter, it will not be exported."
  type                        = list(object({
    name                      = string,
    description               = string,
    filter                    = string,
    disabled                  = bool
  }))
  default                     = [
    {
      name                    = ""
      description             = ""
      filter                  = ""
      disabled                = ""
    }
  ]
}