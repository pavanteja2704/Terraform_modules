variable "account_id" {
  description   = "(Required) The account id that is used to generate the service account email address and a stable unique id."
  type          = string
}
variable "display_name" {
    description = "(Optional) The display name for the service account. Can be updated without creating a new resource."
    type        = string
}
variable "description" {
    description = "(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
    type        = string
}
variable "disabled" {
    description = "(Optional) Whether a service account is disabled or not. Defaults to false"
    type        = bool
}
variable "project_id" {
    description = "(Optional) The ID of the project that the service account will be created in. Defaults to the provider project configuration."
    type        = string 
}
variable "create_ignore_already_exists" {
    description = "(Optional) If set to true, skip service account creation if a service account with the same email already exists."
    type        = bool 
}