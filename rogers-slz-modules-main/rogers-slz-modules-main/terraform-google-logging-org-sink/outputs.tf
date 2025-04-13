output "Organization_Logging_Sink_Details" {
  description = "The filter to be applied when exporting logs."
  value       = google_logging_organization_sink.sink
}