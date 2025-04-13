#...................................................... locals .................................................#

variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}

#.................................................... URL Map ....................................................#

variable "url_map_name" {
  type          = string
  description   = "Name of the resource."
}
variable "url_map_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "backend_bucket_id" {
  type          = string
  description   = "ID of the resource."
}