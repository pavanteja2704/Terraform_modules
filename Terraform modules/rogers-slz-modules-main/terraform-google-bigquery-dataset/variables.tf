variable "project_id" {
  description      = "(Optional) The ID of the project in which the resource belongs."
  type             = string
}

variable "dataset_id" {
  description      = "(Required) A unique ID for this dataset, without the project name."
  type             = string
}

variable "friendly_name" {
  description      = "(Optional) A descriptive name for the dataset"
  type             = string
}

variable "description" {
  default          = "(Optional) A user-friendly description of the dataset"
  type             = string
}

variable "location" {
  description      = "(Optional) The geographic location where the dataset should reside."
  type             = string
}

variable "labels" {
  description      = "(Optional) The labels associated with this dataset."
  type             = map(string)
}

variable "access" {
  description      = "(Optional) An array of objects that define dataset access for one or more entities."
  type             = list(object({
    role           = string
    group_by_email = string
    user_by_email  = string
    special_group  = string
  }))
}