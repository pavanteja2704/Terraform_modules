#...................................................... locals .................................................#

variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}
variable "target_proxy_type" {
  type          = string
  description   = "The target proxy type: HTTP or HTTPS"
}
variable "proxy_name" {
  type          = string
  description   = "Name of the resource."
}
variable "proxy_description" {
  type          = string
  description   = "An optional description of this resource."
}

#.................................................... Proxy ....................................................#

variable "url_map_id" {
  type          = string
  description   = "ID of the url map"
}
variable "ssl_certificates_id" {
  type          = list(string)
  description   = "ID of the ssl certificates"
}