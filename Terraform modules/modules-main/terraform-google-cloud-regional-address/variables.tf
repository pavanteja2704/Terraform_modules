#...................................................... locals ..........................................................#

variable "project_id" {
  type        = string
  description = "The project id to be used"
}
variable "region" {
  type        = string
  description = "The Region in which the created address should reside."
}
variable "address_type" {
  type        = string
  description = "The type of address to reserve."
}
variable "address_purpose" {
  type        = string
  description = "The purpose of the address"
}

#...................................................... Address .........................................................#

variable "address_name" {
  type        = string
  description = "The address name"
}
variable "address_description" {
  type        = string
  description = "An optional description of this resource."
}
variable "network_tier" {
  type        = string
  description = "The networking tier used for configuring this address. If this field is not specified, it is assumed to be PREMIUM."
}
variable "address_prefix_length" {
  type        = number
  description = "The length of the address"
}
variable "address_network" {
  type        = string
  description = "The network of the address"
}
variable "address_subnetwork" {
  type        = string
  description = "The URL of the subnetwork in which to reserve the address."
}
variable "labels" {
  type        = map(string)
  description = "(Optional) Labels to apply to this address. A list of key->value pairs."
}
variable "address_ip" {
  type        = string
  description = "static address"
}
