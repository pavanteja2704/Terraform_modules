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
variable "load_balancing_scheme" {
  type          = string
  description   = "Indicates what kind of load balancing will be used."
}
variable "backend_type" {
  type          = string
  description   = "Indicates what kind of backend for load balancing will be used: MIG or Bucket"
}
variable "enable_cdn" {
  type          = string
  description   = "If true, enable Cloud CDN for this BackendBucket."
}
variable "security_policy" {
  type          = string
  description   = "The security policy associated with this backend service."
}
variable "edge_security_policy" {
  type          = string
  description   = "(Optional) The resource URL for the edge security policy associated with this backend service."
}

#.................................................... URL Map ..................................................#

variable "url_map_name" {
  type          = string
  description   = "Name of the resource."
}
variable "url_map_description" {
  type          = string
  description   = "An optional description of this resource."
}

#.................................................... Proxy ....................................................#

variable "ssl_certificates_id" {
  type          = list(string)
  description   = "ID of the ssl certificates"
}

#................................................. Backend MIG .................................................#

variable "backend_service_name" {
  type          = string
  description   = "Name of the resource."
}
variable "backend_service_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "health_check_id" {
  type          = list(string)
  description   = "The set of URLs to the HttpHealthCheck or HttpsHealthCheck resource for health checking this BackendService."
}
variable "backend_service_protocol" {
  type          = string
  description   = "The protocol this BackendService uses to communicate with backends."
}
variable "backend_service_timeout_sec" {
  type          = string
  description   = "How many seconds to wait for the backend before considering it a failed request."
}
variable "group" {
  type          = string
  description   = "The fully-qualified URL of a Group"
}
variable "balancing_mode" {
  type          = string
  description   = "Specifies the balancing mode for this backend. For global HTTP(S) or TCP/SSL load balancing, the default is UTILIZATION."
}

#................................................ Backend Bucket ...............................................#

variable "backend_bucket_name" {
  type          = string
  description   = "Name of the resource."
}
variable "backend_bucket_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "bucket_name" {
  type          = string
  description   = "Cloud Storage bucket name."
}

#.................................................... Frontend .................................................#

variable "frontend_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "frontend_name" {
  type          = string
  description   = "Name of the resource."
}
variable "ip_protocol" {
  type          = string
  description   = "The IP protocol to which this rule applies. For protocol forwarding, valid options are TCP, UDP, ESP, AH, SCTP, ICMP and L3_DEFAULT"
}
variable "port_range" {
  type          = string
  description   = "The port range of this resource"
}
variable "ip_address" {
  type          = string
  description   = "IP address for which this forwarding rule accepts traffic."
}