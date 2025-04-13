variable "role_id" {
  description = "(Required) The role id to use for this role."
  type        = string
}
variable "org_id" {
  description = "(Required) The numeric ID of the organization in which you want to create a custom role."
  type        = string
}
variable "title" {
  description = "(Required) A human-readable title for the role."
  type        = string
}
variable "permissions" {
  description = "(Required) The names of the permissions this role grants when bound in an IAM policy. At least one permission must be specified."
  type        = list(string)
}
variable "stage" {
  description = "(Optional) The current launch stage of the role. Defaults to GA"
  type        = string
}
variable "description" {
  description = "(Optional) A human-readable description for the role."
  type        = string
}