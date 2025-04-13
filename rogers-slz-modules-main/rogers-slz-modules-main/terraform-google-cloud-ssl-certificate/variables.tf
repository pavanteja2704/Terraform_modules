#...................................................... locals .................................................#
variable "scope" {
  type           = string
  description    = "Scope of the services: global or regional"
}
variable "region" {
  type           = string
  description    = "The region of the project in which the resource belongs."
}
variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}
variable "certificate_type" {
  type          = string
  description   = "Type of ssl certificate: managed or custom"
}
variable "ssl_certificate_name" {
  type          = string
  description   = "Name of the resource."
}
variable "ssl_certificate_description" {
  type          = string
  description   = "An optional description of this resource."
}

#................................................. SSL Certificate ...............................................#

variable "private_key_path" {
  type          = string
  description   = "The write-only private key in PEM format."
}
variable "certificate_path" {
  type          = string
  description   = "The certificate in PEM format."
}
variable "managed" {
  description     = "(Optional) Properties relevant to a managed certificate. These will be used if the certificate is managed (as indicated by a value of MANAGED in type)"
  type            = list(object({
    domains       = list(string)
  }))
}