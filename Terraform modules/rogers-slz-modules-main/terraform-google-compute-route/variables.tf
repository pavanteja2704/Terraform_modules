variable "dest_range" {
  type        = string
  description = "(Required) The destination range of outgoing packets that this route applies to. Only IPv4 is supported."
}
variable "name" {
  type        = string
  description = "(Required) Name of the resource."
}
variable "network" {
  type        = string 
  description = "(Required) The network that this route applies to."
}
variable "description" {
  type        = string 
  description = "(Optional) An optional description of this resource."
}
variable "priority" {
  type        = string 
  description = "(Optional) The priority of this route."
}
variable "tags" {
  type        = list(string) 
  description = "(Optional) A list of instance tags to which this route applies."
}
variable "next_hop_gateway" {
  type        = string 
  description = "(Optional) URL to a gateway that should handle matching packets."
}
variable "next_hop_instance" {
  type        = string 
  description = "(Optional) URL to an instance that should handle matching packets."
}
variable "next_hop_ip" {
  type        = string 
  description = "(Optional) Network IP address of an instance that should handle matching packets."
}
variable "next_hop_vpn_tunnel" {
  type        = string 
  description = "(Optional) URL to a VpnTunnel that should handle matching packets."
}
variable "next_hop_ilb" {
  type        = string 
  description = "(Optional) The IP address or URL to a forwarding rule of type loadBalancingScheme=INTERNAL that should handle matching packets."
}
variable "project_id" {
  type        = string
  description = "The ID of the project where the routes will be created"
}
variable "next_hop_instance_zone" {
  type        = string 
  description = "(Optional when next_hop_instance is specified) The zone of the instance specified in next_hop_instance. Omit if next_hop_instance is specified as a URL."
}