variable "scope" {
  type          = string
  description   = "Scope of the service global or regional"
}
variable "project_id" {
    type        = string
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  
}
variable "region" {
  type          = string
  description   = "The region where the regional SSL policy resides."
}
variable "name" {
    type        = string
    description = "Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
  
}
variable "description" {
    type          = string
    description   = "An optional description of this resource."
  
}
variable "profile" {
    type          = string
    description   = " (Optional) Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients."
  
}
variable "min_tls_version" {
    type          = string
    description   = "The minimum version of SSL protocol that can be used by the clients to establish a connection with the load balancer."
  
}
variable "custom_features" {
    type          = list(string)
    description   = "Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients. This can be one of COMPATIBLE, MODERN, RESTRICTED, or CUSTOM."
  
}