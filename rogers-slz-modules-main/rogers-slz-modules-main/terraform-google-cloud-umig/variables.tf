#...................................................... locals .................................................#

variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}
variable "zone" {
  type          = string
  description   = "(Required) The zone that this instance group should be created in."
}
variable "network" {
  type          = string
  description   = " (Optional) The URL of the network to which this backend service belongs."
}

#................................................. Instance Group ..............................................#

variable "umig_name" {
  type          = string
  description   = "(Required) The name of the instance group."
}
variable "umig_description" {
  type          = string
  description   = "(Optional) An optional textual description of the instance group."
}
variable "umig_instances" {
  type          = list(string)
  description   = "(Optional) The list of instances in the group, in self_link format."
}
variable "named_port" {
  description   = "(Optional) The named port configuration. See the section below for details on configuration."
  type          = list(object({
    name        = string,
    port        = string
  }))
  default       = []
}