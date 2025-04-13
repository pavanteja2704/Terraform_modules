variable "neg_name" {
    type                  = string
    description           = "(Required) Name of the resource; provided by the client when the resource is created."
}
variable "region" {
    type                  = string
    description           = "(Required) A reference to the region where the regional NEGs reside."
}
variable "description" {
    type                  = string
    description           = "(Optional) An optional description of this resource."
}
variable "network_endpoint_type" {
    type                  = string
    description           = "(Optional) Type of network endpoints in this network endpoint group."
}
variable "psc_target_service" {
    type                  = string
    description           = " (Optional) This field is only used for PSC and INTERNET NEGs."
}
variable "network" {
    type                  = string
    description           = "(Optional) This field is only used for PSC and INTERNET NEGs. The URL of the network to which all network endpoints in the NEG belong."
}
variable "subnetwork" {
    type                  = string
    description           = "(Optional) This field is only used for PSC NEGs. Optional URL of the subnetwork to which all network endpoints in the NEG belong"
}
variable "cloud_run" {
  description             = "(Optional) This field is only used for SERVERLESS NEGs. Only one of cloud_run, app_engine, cloud_function or serverless_deployment may be set"
  type                    = list(object({
    service               = string
    tag                   = string
    url_mask              = string
  }))
}
variable "app_engine" {
  description            = "(Optional) This field is only used for SERVERLESS NEGs. Only one of cloud_run, app_engine, cloud_function or serverless_deployment may be set."
  type                   = list(object({
    service              = string
    version              = string
    url_mask             = string
  }))
}
variable "cloud_function" {
  description            = "(Optional) This field is only used for SERVERLESS NEGs. Only one of cloud_run, app_engine, cloud_function or serverless_deployment may be set."
  type                   = list(object({
    function             = string
    url_mask             = string
  }))
}
variable "serverless_deployment" {
  description            = "(Optional) This field is only used for SERVERLESS NEGs. Only one of cloud_run, app_engine, cloud_function or serverless_deployment may be set."
  type                   = list(object({
    platform             = string
    resource             = string
    version              = string
    url_mask             = string
  }))
}
variable "project_id" {
    type                 = string
    description          = "(Optional) The ID of the project in which the resource belongs."
}


variable "create_endpoint" {
    type                  = bool
    description           = "Whether to create endpoint or not"
}
variable "port" {
    type                  = string
    description           = "Port number of network endpoint."
}
variable "ip_address" {
    type                  = string
    description           = "IPv4 address external endpoint. This can only be specified when network_endpoint_type of the NEG is INTERNET_IP_PORT."
}
variable "fqdn" {
    type                  = string
    description           = "Fully qualified domain name of network endpoint."
}