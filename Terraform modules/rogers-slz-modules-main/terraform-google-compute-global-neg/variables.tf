variable "project_id"{
    type = string
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}
variable "name" {
    type = string 
    description = "(Required) Name of the resource; provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
}

variable "default_port" {
    type = string
    description = "(Optional) The default port used if the port number is not specified in the network endpoint."
}

variable "network_endpoint_type" {
    type = string
    description = "(Required) Type of network endpoints in this network endpoint group. Possible values are: INTERNET_IP_PORT, INTERNET_FQDN_PORT."
  
}


variable "create_endpoint" {
    type                  = bool
    description           = "Whether to create endpoint or not"
}
variable "port" {
    type = string
    description = "(Required) Port number of the external endpoint."
  
}
variable "ip_address" {
    type = string
    description = "(Optional) IPv4 address external endpoint."
  
}
variable "fqdn" {
    type = string
    description = "(Optional) Fully qualified domain name of network endpoint. This can only be specified when network_endpoint_type of the NEG is INTERNET_FQDN_PORT."
  
}