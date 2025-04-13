variable "project_id" {
  description = "GCP project id."
  type        = string
}

variable "security_policy_name" {
  type = string
  description = "The name of the security policy"
}

variable "policy_type" {
  type = string
  description = "The type indicates the intended use of the security policy."
}

variable "action_type" {
  type = string
  description = "Action to take when match matches the request"
}

variable "action_priority" {
  type = string
  description = "An unique positive integer indicating the priority of evaluation for a rule"
}

variable "policy_versioned_expr" {
  type = string
  description = "Predefined rule expression. If this field is specified, config must also be specified"
}

variable "policy_src_ip_ranges" {
  type = list(string)
  description = "Set of IP addresses or ranges (IPV4 or IPV6) in CIDR notation to match against inbound traffic"
}

variable "rule_description" {
  type = string
  description = "An optional description of this rule"
}

/* variable "deny_action" {
  type = string
  description = "Action to take when match matches the request"
}

variable "deny_action_priority" {
  type = string
  description = "An unique positive integer indicating the priority of evaluation for a rule"
}

variable "deny_policy_versioned_expr" {
  type = string
  description = "Predefined rule expression. If this field is specified, config must also be specified"
}

variable "deny_policy_src_ip_ranges" {
  type = list(string)
  description = "Set of IP addresses or ranges (IPV4 or IPV6) in CIDR notation to match against inbound traffic"
}

variable "deny_rule_description" {
  type = string
  description = "An optional description of this rule"
}

variable "default_action" {
  type = string
  description = "Action to take when match matches the request"
}

variable "default_action_priority" {
  type = string
  description = "An unique positive integer indicating the priority of evaluation for a rule"
}

variable "default_policy_versioned_expr" {
  type = string
  description = "Predefined rule expression. If this field is specified, config must also be specified"
}

variable "default_policy_src_ip_ranges" {
  type = list(string)
  description = "Set of IP addresses or ranges (IPV4 or IPV6) in CIDR notation to match against inbound traffic"
}

variable "default_rule_description" {
  type = string
  description = "An optional description of this rule"
} */
