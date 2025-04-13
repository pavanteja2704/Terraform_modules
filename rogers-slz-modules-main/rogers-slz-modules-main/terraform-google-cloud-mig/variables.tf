#...................................................... locals .................................................#

variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}
variable "region" {
  type          = string
  description   = "An instance template is a global resource that is not bound to a zone or a region."
}

#.................................................. Health Check ................................................#

variable "health_check_name" {
  type          = string
  description   = "Name of the resource. "
}
variable "health_check_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "check_interval_sec" {
  type          = string
  description   = "How often (in seconds) to send a health check."
}
variable "timeout_sec" {
  type          = string
  description   = "How long (in seconds) to wait before claiming failure."
}
variable "healthy_threshold" {
  type          = string
  description   = "A so-far unhealthy instance will be marked healthy after this many consecutive successes."
}
variable "unhealthy_threshold" {
  type          = string
  description   = "A so-far healthy instance will be marked unhealthy after this many consecutive failures."
}
variable "health_check_port" {
  type          = number
  description   = "The TCP port number for the TCP health check request."
}