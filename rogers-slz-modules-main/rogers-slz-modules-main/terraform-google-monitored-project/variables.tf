variable "monitored_project" {
  description = "(Required) Immutable. The resource name of the MonitoredProject."
  type        = map(any)
}
variable "monitoring_project" {
  description = "(Required) Required. The resource name of the existing Metrics Scope that will monitor this project."
  type        = string
}
