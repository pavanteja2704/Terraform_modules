variable "host_project_id" {
  description = "The ID of the host project which hosts the shared VPC"
  type        = string
}

variable "service_project_id" {
  description = "The ID of the service project"
  #type        = list(string)
  type        = string
}