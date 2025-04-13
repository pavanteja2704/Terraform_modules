#...................................................... locals .................................................#

variable "scope" {
  type        = string
  description = "Scope of the services: global or regional"
}
variable "project_id" {
  description = "GCP project id."
  type        = string
}
variable "region" {
  description = "(Optional) The Region in which the created Region Security Policy should reside. If it is not provided, the provider region is used." 
  type        = string
}
variable "security_policy_type" {
  type = string
  description = "The type indicates the intended use of the security policy."
}
variable "security_policy_name" {
  type = string
  description = "The name of the security policy"
}
variable "security_policy_description" {
  type = string
  description = "An optional description of this rule"
}
#...................................................... locals .................................................#


#................................................ Regional Policy ..............................................#

variable "ddos_protection_config" {
  description                 = "(Optional) Configuration for Google Cloud Armor DDOS Proctection Config."
    type                        = list(object({
     ddos_protection = string
    }))
}

variable "user_defined_fields" {
    description = "(Optional) Definitions of user-defined fields for CLOUD_ARMOR_NETWORK policies."
    type = list(object({
      name = string
      base = string
      offset = number
      size = number
      mask = number
    }))
}
#................................................ Regional Policy ..............................................#


#................................................. Global Policy ...............................................#

/* variable "security_policy_log_level" {
  type = string
  description = "Log level to use. Defaults to NORMAL"
}
variable "security_policy_json_parsing" {
  type = string
  description = "Whether or not to JSON parse the payload body. Defaults to DISABLED"
} */

# --------------------------------- 
# Default rules
# --------------------------------- 
variable "security_policy_default_rules" {
    type = map(object({
        action              = string
        priority            = string
        versioned_expr      = string
        src_ip_ranges       = list(string)
        description         = string
        preview             = bool
        })
    )
} 

# --------------------------------- 
# Throttling traffic rules
# --------------------------------- 
variable "security_policy_throttle_rules" {
    type = map(object({
        action                              = string
        priority                            = string
        versioned_expr                      = string
        src_ip_ranges                       = list(string)
        description                         = string
        conform_action                      = string
        exceed_action                       = string
        enforce_on_key                      = string
        rate_limit_threshold_count          = number
        rate_limit_threshold_interval_sec   = number
        preview                             = bool
        })
    )
} 

# --------------------------------- 
# Countries limitation rules
# --------------------------------- 
variable "security_policy_countries_rules" {
    type = map(object({
        action                              = string
        priority                            = string
        expression                          = string
        description                         = string
        preview                             = bool
        })
    )
} 
# --------------------------------- 
# OWASP rules
# --------------------------------- 
variable "security_policy_owasp_rules" {
    type = map(object({
        action      = string
        priority    = string
        description = string
        preview     = bool
        expression  = string
        })
    )
}
# --------------------------------- 
# Custom rules
# --------------------------------- 
variable "security_policy_cves_and_vulnerabilities_rules" {
    type = map(object({
        action      = string
        priority    = string
        description = string
        preview     = bool
        expression  = string
        })
    )
}

#................................................. Global Policy ...............................................#