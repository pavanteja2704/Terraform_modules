variable "project_id" {
  type = string
  description = "The project id for putting the VM"
}

variable "zone" {
  type = string
  description = "The zone that the machine should be created in"
}

variable "name" {
  type = string
  description = "Name of the VM"
}

variable "tags" {
  type = list(string)
  description = "A list of network tags to attach to the instance"
}

variable "labels" {
  type = map(string)
  description = "A map of key/value label pairs to assign to the instance"
}

variable "metadata" {
  type = map(string)
  description = "Metadata key/value pairs to make available from within the instance"
}

variable "machine_type" {
  type = string
  description = "The machine Type of VM"
}

variable "deletion_protection" {
    type = bool
    description = "Enable/Disable deletion protection on the instance"
}

variable "image" {
  type = string
  description = "The image from which to initialize this disk"
}
variable "size" {
  type = string
  description = "The size of the image in gigabytes."
}
variable "type" {
  type = string
  description = "(Optional) The GCE disk type. Such as pd-standard, pd-balanced or pd-ssd."
}

variable "attached_disk" {
  description     = "(Optional) Additional disks to attach to the instance."
  type            = list(object({
    source        = string
  }))
}

variable "can_ip_forward" {
  type        = bool
  description = "(Optional) Whether to allow sending and receiving of packets with non-matching source or destination IPs."
}
variable "desired_status" {
  type        = string
  description = "(Optional) Desired status of the instance. Either RUNNING or TERMINATED"
}
variable "allow_stopping_for_update" {
  type        = bool
  description = "(Optional) If true, allows Terraform to stop the instance to update its properties."
}

variable "network_interfaces" {
  description     = "List of network interfaces"
  type            = list(object({
    subnetwork    = string
    network_ip    = string
    nic_type      = string
    access_config = list(object({
      nat_ip      = string
    }))
  }))
}

variable "service_account_email" {
  type = string
  description = "The service account e-mail address"
}

variable "service_account_scopes" {
  type = list(string)
  description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope"
}

variable "preemptible" {
  type = bool
  description = "(Optional) Specifies if the instance is preemptible."
}
variable "automatic_restart" {
  type = bool
  description = "(Optional) Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user)."
}