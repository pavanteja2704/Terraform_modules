#...................................................... locals .................................................#

variable "project_id" {
  type          = string
  description   = "The ID of the project in which the resource belongs."
}
variable "region" {
  type          = string
  description   = "An instance template is a global resource that is not bound to a zone or a region."
}
variable "network" {
  type          = string
  description   = " (Optional) The URL of the network to which this backend service belongs."
}
variable "subnetwork" {
  type          = string
  description   = "(Optional) This field identifies the subnetwork that the load balanced IP should belong to for this Forwarding Rule."
}
variable "backend_type" {
  type          = string
  description   = "Indicates what kind of backend type for load balancing will be used: target_pool or backend_service"
}
variable "load_balancing_scheme" {
  type          = string
  description   = "Indicates what kind of load balancing will be used."
}

#................................................ Target Pool ..................................................#

variable "target_pool_name" {
  type          = string
  description   = "A unique name for the resource, required by GCE"
}
variable "target_pool_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "instances" {
  type          = list(string)
  description   = "List of instances in the pool. They can be given as URLs, or in the form of zone/name."
}
variable "health_check_self_link" {
  type          = list(string)
  description   = "List of zero or one health check name or self_link."
}

#.................................................... Backend ...................................................#

variable "backend_description" {
  type          = string
  description   = "An optional description of this resource."
}
variable "backend_name" {
  type          = string
  description   = "Name of the resource."
}
variable "backend_protocol" {
  type          = string
  description   = "The protocol this RegionBackendService uses to communicate with backends."
}
variable "backend_timeout_sec" {
  type          = string
  description   = "How many seconds to wait for the backend before considering it a failed request. "
}
variable "health_check_id" {
  type          = list(string)
  description   = "ID of the existing health check"
}
variable "backend" {
  type          = list(object(
    {
      group     = string
    }))
  description   = "(Optional) The set of backends that serve this RegionBackendService."
}
variable "log_config" {
  type          = list(object(
    {
      enable    = bool
      sample_rate = number
    }))
  description   = "(Optional) The set of backends that serve this RegionBackendService."
}
/* variable "mig_id" {
  type          = string
  description   = "ID of the existing MIG"
}
variable "backend_balancing_mode" {
  type          = string
  description   = "Specifies the balancing mode for this backend."
}
variable "backend_capacity_scaler" {
  type          = string
  description   = "A multiplier applied to the group's maximum servicing capacity"
} */

#.................................................. Frontend ....................................................#

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
variable "all_ports" {
  type          = bool
  description   = "The ports, portRange, and allPorts fields are mutually exclusive. Only packets addressed to ports in the specified range will be forwarded to the backends configured with this forwarding rule."
}
variable "ip_address" {
  type          = string
  description   = "IP address for which this forwarding rule accepts traffic."
}
variable "port_range" {
  type          = number
  description   = "The ports, portRange, and allPorts fields are mutually exclusive. Only packets addressed to ports in the specified range will be forwarded to the backends configured with this forwarding rule."
}
variable "ports" {
  type          = list(string)
  description   = "The ports, portRange, and allPorts fields are mutually exclusive. Only packets addressed to ports in the specified range will be forwarded to the backends configured with this forwarding rule."
}
variable "allow_global_access" {
  type          = bool
  description   = "(Optional) This field is used along with the backend_service field for internal load balancing or with the target field for internal TargetInstance."
}
variable "labels" {
  type          = map(string)
  description   = "(Optional) Labels to apply to this forwarding rule. A list of key->value pairs."
}