#...................................................... locals ..........................................................#

variable "project_id" {
  type        = string
  description = "The project id to be used"
}
variable "global_address_type" {
  type        = string
  description = "The type of the address to reserve."
}

#................................................... Global Address .....................................................#

variable "global_address_name" {
  type        = string
  description = "The address name"
}
variable "global_address_description" {
  type        = string
  description = "An optional description of this resource."
}
variable "global_address_purpose" {
  type        = string
  description = "The purpose of the address"
}
variable "global_address_prefix_length" {
  type        = number
  description = "The length of the address"
}
variable "global_address_network" {
  type        = string
  description = "The network of the address"
}
variable "labels" {
  type        = map(string)
  description = "(Optional) Labels to apply to this address. A list of key->value pairs."
}
variable "global_address_ip" {
  type        = string
  description = "static address"
}