variable "neg_name" {
    type                  = string
    description           = "Name of the resource; provided by the client when the resource is created"
}
variable "network_name" {
    type                  = string
    description           = "The network to which all network endpoints in the NEG belong. Uses default project network if unspecified"
}
variable "description" {
    type                  = string
    description           = "An optional description of this resource. Provide this property when you create the resource"
}
variable "network_endpoint_type" {
    type                  = string
    description           = " Default value is GCE_VM_IP_PORT. Possible values are: GCE_VM_IP, GCE_VM_IP_PORT, NON_GCP_PRIVATE_IP_PORT, INTERNET_IP_PORT, INTERNET_FQDN_PORT, SERVERLESS, PRIVATE_SERVICE_CONNECT"
}
variable "subnetwork" {
    type                  = string
    description           = "Optional subnetwork to which all network endpoints in the NEG belong"
}
variable "default_port" {
    type                  = string
    description           = "The default port used if the port number is not specified in the network endpoint."
}
variable "zone" {
    type                  = string
    description           = "Zone where the network endpoint group is located"
}
variable "project_id" {
    type                  = string
    description           = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used"
}


variable "create_endpoint" {
    type                  = bool
    description           = "Whether to create endpoint or not"
}
variable "ip_address" {
  description         = "(Required) IPv4 address of network endpoint. The IP address must belong to a VM in GCE"
  type                = string
}
variable "instance" {
  description         = "(Optional) The name for a specific VM instance that the IP address belongs to."
  type                = string
}
variable "port" {
  description         = "(Optional) Port number of network endpoint."
  type                = string
}
variable "zone" {
  description         = "(Optional) Zone where the containing network endpoint group is located."
  type                = string
}



variable "create_endpoints" {
    type                  = bool
    description           = "Whether to create endpoints or not"
}
variable "network_endpoints" {
  description             = "The network endpoints to be added to the enclosing network endpoint group (NEG)"
  type                    = list(object({
    instance              = string
    port                  = string
    ip_address            = string
  })) 
}
variable "zone" {
  description             = "Zone where the containing network endpoint group is located."
  type                    = string
}
