#...................................................... locals .................................................#

variable "scope" {
  type                                  = string
  description                           = "Scope of the services: global or regional"
}
variable "project_id" {
  type                                  = string
  description                           = "The ID of the project in which the resource belongs."
}
variable "region" {
  type                                  = string
  description                           = "The region of the project in which the resource belongs."
}
variable "load_balancing_scheme" {
  type                                  = string
  description                           = "Indicates what kind of load balancing will be used."
}


variable "frontend_description" {
  type                                  = string
  description                           = "An optional description of this resource."
}
variable "frontend_name" {
  type                                  = string
  description                           = "Name of the resource."
}
variable "ip_protocol" {
  type                                  = string
  description                           = "The IP protocol to which this rule applies. For protocol forwarding, valid options are TCP, UDP, ESP, AH, SCTP, ICMP and L3_DEFAULT"
}
variable "port_range" {
  type                                  = string
  description                           = "The port range of this resource"
}
variable "ip_address" {
  type                                  = string
  description                           = "IP address for which this forwarding rule accepts traffic."
}
variable "network" {
  type                                  = string
  description                           = "(Optional) This field is not used for external load balancing."
}
variable "subnetwork" {
  type                                  = string
  description                           = "(Optional) This field identifies the subnetwork that the load balanced IP should belong to for this Forwarding Rule"
}
variable "labels" {
  type                                  = map(string)
  description                           = "(Optional) Labels to apply to this forwarding rule. A list of key->value pairs."
}
variable "source_ip_ranges" {
  type                                  = list(string)
  description                           = "(Optional) If not empty, this Forwarding Rule will only forward the traffic when the source IP address matches one of the IP addresses or CIDR ranges set here."
}
variable "ip_version" {
  type                                  = string
  description                           = "(Optional) The IP address version that will be used by this forwarding rule."
}
variable "allow_psc_global_access" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to control whether the PSC endpoint can be accessed from another region."
}
variable "no_automate_dns_zone" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to control whether it should try to auto-generate a DNS zone or not. Non-PSC forwarding rules do not use this field."
}
variable "service_directory_registrations" {
  description                           = "(Optional) Service Directory resources to register this forwarding rule with. "
  type                                  = list(object({
    namespace                           = string
    service                             = string
    service_directory_region            = string
  }))
}

#.................................................... Frontend .................................................#

variable "frontend_project_id" {
  type                                  = string
  description                           = "(Optional) The ID of the project in which the resource belongs."
}
variable "is_mirroring_collector" {
  type                                  = string
  description                           = "(Optional) Indicates whether or not this load balancer can be used as a collector for packet mirroring."
}
variable "backend_service" {
  type                                  = string
  description                           = "(Optional) Identifies the backend service to which the forwarding rule sends traffic."
}
variable "ports" {
  type                                  = list(string)
  description                           = "(Optional) The ports, portRange, and allPorts fields are mutually exclusive."
}
variable "target_proxy_id" {
  type                                  = string
  description                           = "(Optional) ID of the Target Proxy"
}
variable "allow_global_access" {
  type                                  = bool
  description                           = "(Optional) This field is used along with the backend_service field for internal load balancing or with the target field for internal TargetInstance."
}
variable "all_ports" {
  type                                  = string
  description                           = "(Optional) The ports, portRange, and allPorts fields are mutually exclusive."
}
variable "network_tier" {
  type                                  = string
  description                           = "(Optional) This signifies the networking tier used for configuring this load balancer and can only take the following values: PREMIUM, STANDARD"
}
variable "service_label" {
  type                                  = string
  description                           = "(Optional) An optional prefix to the service name for this Forwarding Rule."
}
variable "recreate_closed_psc" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to make terraform recreate the ForwardingRule when the status is closed"
}

variable "metadata_filters" {
  description                           = "(Optional) Opaque filter criteria used by Loadbalancer to restrict routing configuration to a limited set xDS compliant clients."
  type                                  = list(object({
    filter_match_criteria               = string
    filter_labels                       = list(object({
      name                              = string
      value                             = string
    }))
  }))
}