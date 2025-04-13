variable "disk_name" {
  description = "(Required) Name of the resource."
  type        = string
}
variable "project_id" {
  description = "Project ID where disk needs to be created and attached"
  type        = string
}
variable "labels" {
  description = "Labels to be attached to the Disk"
  type        = map(string)
}
variable "size" {
  description = "(Optional) Size of the persistent disk, specified in GB."
  type        = number
}
variable "description" {
  description = "(Optional) An optional description of this resource."
  type        = string
}
variable "type" {
  description = "(Optional) URL of the disk type resource describing which disk type to use to create the disk."
  type        = string
}
variable "zone" {
  description = "(Optional) A reference to the zone where the disk resides."
  type        = string
}
variable "image" {
  type        = string
  description = "(Optional) The image from which to initialize this disk."
}
variable "physical_block_size_bytes" {
  type        = string
  description = "(Optional) Physical block size of the persistent disk, in bytes."
}