variable "project_id" {
  description               = "(Optional) Project where resources will be created."
  type                      = string
}
variable "region" {
  description               = "(Optional) Region used for resources."
  type                      = string
}
variable "network" {
  description               = "(Required) VPC used for the gateway and routes."
  type                      = string
}
variable "create_vpn_gateway" {
  description               = "(Required) Create a VPN gateway"
  type                      = bool
}
variable "vpn_gateway_name" {
  description               = "(Required) VPN gateway name."
  type                      = string
}
variable "vpn_gateway_description" {
  description               = "(Optional) An optional description of this resource."
  type                      = string
}



variable "create_ha_vpn_gateway" {
  description               = "(Required) Create a HA VPN gateway"
  type                      = bool
}
variable "ha_vpn_gateway_name" {
  description               = "(Required) HA VPN gateway name."
  type                      = string
}
variable "ha_vpn_gateway_description" {
  description               = "(Optional) An optional description of this resource."
  type                      = string
}
variable "stack_type" {
  description               = "(Optional) The stack type for this VPN gateway to identify the IP protocols that are enabled. If not specified, IPV4_ONLY will be used. Default value is IPV4_ONLY. Possible values are: IPV4_ONLY, IPV4_IPV6."
  type                      = string
}
variable "vpn_interfaces" {
  description               = "(Optional) A list of interfaces on this VPN gateway."
  type                      = list(object({
    id                      = string
    ip_address              = string
    interconnect_attachment = string
  }))
}


variable "create_router" {
  description               = "(Required) Create a router"
  type                      = bool
}
variable "router_name" {
  description               = "(Required) Name of the resource. "
  type                      = string
}
variable "router_description" {
  description               = "(Optional) An optional description of this resource."
  type                      = string
}
variable "bgp" {
  description               = "(Optional) BGP information specific to this router."
  type                      = list(object({
    asn                     = string
    advertise_mode          = string
    advertised_groups       = string
    advertised_ip_ranges    = list(object({
      range                 = string
      description           = sring
    }))
    keepalive_interval      = string
  }))
}
variable "encrypted_interconnect_router" {
  description               = "(Optional) Indicates if a router is dedicated for use with encrypted VLAN attachments (interconnectAttachments)."
  type                      = string
}



variable "create_interconnect_attachment" {
  description               = "(Required) Create a interconnect attachment"
  type                      = bool
}
variable "interconnect_attachment_name" {
  description               = "(Required) Name of the resource."
  type                      = string
}
variable "admin_enabled" {
  description               = "(Optional) Whether the VLAN attachment is enabled or disabled. When using PARTNER type this will Pre-Activate the interconnect attachment"
  type                      = bool
}
variable "interconnect" {
  description               = "(Optional) URL of the underlying Interconnect object that this attachment's traffic will traverse through."
  type                      = string
}
variable "interconnect_attachment_description" {
  description               = "(Optional) An optional description of this resource."
  type                      = string
}
variable "interconnect_attachment_mtu" {
  description               = "(Optional) Maximum Transmission Unit (MTU), in bytes, of packets passing through this interconnect attachment. Currently, only 1440 and 1500 are allowed. If not specified, the value will default to 1440."
  type                      = string
}
variable "bandwidth" {
  description               = "(Optional) Provisioned bandwidth capacity for the interconnect attachment."
  type                      = string
}
variable "edge_availability_domain" {
  description               = "(Optional) Desired availability domain for the attachment."
  type                      = string
}
variable "type" {
  description               = "(Optional) The type of InterconnectAttachment you wish to create. Defaults to DEDICATED. Possible values are: DEDICATED, PARTNER, PARTNER_PROVIDER."
  type                      = string
}
variable "candidate_subnets" {
  description               = "(Optional) Up to 16 candidate prefixes that can be used to restrict the allocation of cloudRouterIpAddress and customerRouterIpAddress for this attachment.(Optional) Up to 16 candidate prefixes that can be used to restrict the allocation of cloudRouterIpAddress and customerRouterIpAddress for this attachment."
  type                      = string
}
variable "vlan_tag8021q" {
  description               = "(Optional) The IEEE 802.1Q VLAN tag for this attachment, in the range 2-4094. When using PARTNER type this will be managed upstream."
  type                      = string
}
variable "ipsec_internal_addresses" {
  description               = "(Optional) URL of addresses that have been reserved for the interconnect attachment,"
  type                      = string
}
variable "encryption" {
  description               = "(Optional) Indicates the user-supplied encryption option of this interconnect attachment. Can only be specified at attachment creation for PARTNER or DEDICATED attachments."
  type                      = string
}
variable "interconnect_attachment_stack_type" {
  description               = "(Optional) The stack type for this interconnect attachment to identify whether the IPv6 feature is enabled or not."
  type                      = string
}




variable "router_interface_name" {
  description               = "(Required) A unique name for the interface, required by GCE."
  type                      = string
}
variable "ip_range" {
  description               = "(Optional) IP address and range of the interface."
  type                      = string
}
variable "redundant_interface" {
  description               = "(Optional) The name of the interface that is redundant to this interface."
  type                      = string
}
variable "subnetwork" {
  description               = "(Optional) The URI of the subnetwork resource that this interface belongs to, which must be in the same region as the Cloud Router."
  type                      = string
}
variable "private_ip_address" {
  description               = "(Optional) The regional private internal IP address that is used to establish BGP sessions to a VM instance acting as a third-party Router Appliance."
  type                      = string
}



variable "router_peer_name" {
  description               = "(Required) Name of this BGP peer."
  type                      = string
}
variable "router_peer_asn" {
  description               = "(Required) Peer BGP Autonomous System Number (ASN). Each BGP interface may use a different value."
  type                      = string
}
variable "router_ip_address" {
  description               = "(Optional) IP address of the interface inside Google Cloud Platform. Only IPv4 is supported."
  type                      = string
}
variable "router_peer_ip_address" {
  description               = "(Optional) IP address of the BGP interface outside Google Cloud Platform. Only IPv4 is supported"
  type                      = string
}
variable "advertised_route_priority" {
  description               = "(Optional) The priority of routes advertised to this BGP peer."
  type                      = string
}
variable "advertise_mode" {
  description               = "(Optional) User-specified flag to indicate which mode to use for advertisement. Valid values of this enum field are: DEFAULT, CUSTOM Default value is DEFAULT. Possible values are: DEFAULT, CUSTOM."
  type                      = string
}



variable "route_priority" {
  description = "Route priority, defaults to 1000."
  type        = number
  default     = 1000
}

variable "router_advertise_config" {
  description = "Router custom advertisement configuration, ip_ranges is a map of address ranges and descriptions."
  type = object({
    groups    = list(string)
    ip_ranges = map(string)
    mode      = string
  })
  default = null
}

variable "router_asn" {
  description = "Router ASN used for auto-created router."
  type        = number
  default     = 64514
}


variable "tunnels" {
  description = "VPN tunnel configurations, bgp_peer_options is usually null."
  type = map(object({
    bgp_session_range               = string
    ike_version                     = number
    vpn_gateway_interface           = number
    peer_external_gateway_interface = number
    shared_secret                   = string
    router_interface_name           = string
    # router_peer_name                = string
    tunnel_name                     = string
  }))
  default = {}
}

# variable "tunnels" {
#   description = "VPN tunnel configurations, bgp_peer_options is usually null."
#   type = map(object({
#     bgp_peer = object({
#       address = string
#       asn     = number
#     })
#     bgp_peer_options = object({
#       advertise_groups    = list(string)
#       advertise_ip_ranges = map(string)
#       advertise_mode      = string
#       route_priority      = number
#     })
#     bgp_session_range               = string
#     ike_version                     = number
#     vpn_gateway_interface           = number
#     peer_external_gateway_interface = number
#     shared_secret                   = string
#     router_interface_name           = string
#     # router_peer_name                = string
#     tunnel_name                     = string
#   }))
#   default = {}
# }

variable "vpn_gateway_self_link" {
  description = "self_link of existing VPN gateway to be used for the vpn tunnel"
  default     = null
}





variable "labels" {
  description = "Labels for vpn components"
  type        = map(string)
  default     = {}
}

variable "peer_gcp_gateway" {
  description = "Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected."
  type        = string
  default     = null
}

variable "peer_external_gateway" {
  description = "Configuration of an external VPN gateway to which this VPN is connected."
  type = object({
    redundancy_type = string
    interfaces = list(object({
      id         = number
      ip_address = string
    }))
  })
  default = null
}

variable "external_vpn_gateway_name" {
  description = "External VPN gateway name"
  type        = string
  default     = ""
}
