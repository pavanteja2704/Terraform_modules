/* variable "policy" {
  description = "Allow/Deny policy"
  type        = string
  default     = null
}
variable "project_id" {
  description = "The project id for putting the policy"
  type        = string
  default     = null
}
variable "allow" {
  description = "(Only for list constraints) List of values which should be allowed"
  type        = list(string)
  default     = [""]
}
variable "constraint" {
  description = "The constraint to be applied"
  type        = string
}
variable "default" {
  description = "Values which should be excluded"
  type        = bool
  default     = false
} */



variable "project_id" {
  description             = "(Required) The project id of the project to set the policy for."
  type                    = string
}
variable "constraint" {
  description             = "(Required) The name of the Constraint the Policy is configuring."
  type                    = string
}
variable "policy_version" {
  description             = "(Optional) Version of the Policy. Default version is 0."
  type                    = string
}
variable "boolean_policy" {
  description             = "(Optional) A boolean policy is a constraint that is either enforced or not."
  type                    = list(object({
    enforced              = bool
  }))
}
variable "list_policy" {
  description             = "(Optional) A policy that can define specific values that are allowed or denied for the given constraint. It can also be used to allow or deny all values."
  type                    = list(object({
    allow                 = list(object({
      all                 = bool
      values              = list(string)
    }))
    deny                  = list(object({
      all                 = bool
      values              = list(string)
    }))
    suggested_value       = string
    inherit_from_parent   = string
  }))
}
variable "restore_policy" {
  description             = "(Optional) A restore policy is a constraint to restore the default policy."
  type                    = list(object({
    default               = bool
  }))
}