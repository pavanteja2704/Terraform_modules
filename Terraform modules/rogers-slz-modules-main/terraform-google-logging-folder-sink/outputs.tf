output "Folder_Logging_Sink_Details" {
  description = "The filter to be applied when exporting logs."
  value       = google_logging_folder_sink.sink
}