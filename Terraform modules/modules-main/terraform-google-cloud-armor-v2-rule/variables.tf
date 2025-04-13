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
variable "security_policy" {
  description = "(Required) The name of the security policy this rule belongs to." 
  type        = string
}
variable "security_policy_rule_description" {
    type                  = string
    description           = "(Optional) An optional description of this resource. Provide this property when you create the resource."
}
variable "match"{
    description ="(Optional) A match condition that incoming traffic is evaluated against. If it evaluates to true, the corresponding 'action' is enforced."
    type = list(object({
        versioned_expr   = string
        expr    = list(object({
            expression = list(string)
        }))
        config    = list(object({
            src_ip_ranges = list(string)
        }))
    }))
}
#...................................................... locals .................................................#


#.............................................. Region Policy Rule .............................................#

variable "priority" {
    type                  = number
    description           = " (Required) An integer indicating the priority of a rule in the list."
}
variable "action" {
    type                  = string
    description           = "(Required) The Action to perform when the rule is matched"
}
variable "preview" {
    type                  = string
    description           = "(Optional) If set to true, the specified action is not enforced."
}
variable "network_match"{
    description = " (Optional) A match condition that incoming packets are evaluated against for CLOUD_ARMOR_NETWORK security policies."
    type = list(object({
            src_ip_ranges       = list(string)
            dest_ip_ranges      = list(string)
            ip_protocols        = list(string)
            src_ports           = list(string)
            dest_ports          = list(string)
            src_region_codes    = list(string)
            src_asns            = list(string)
            user_defined_fields = list(object({
                name      = string
                values    = list(string)
            }))
    }))
}
#.............................................. Region Policy Rule .............................................#


#.............................................. Global Policy Rule .............................................#

variable "preconfigured_waf_config"{
  description = "Optional) Preconfigured WAF configuration to be applied for the rule. If the rule does not evaluate preconfigured WAF rules"
  type = list(object({
    target_rule_set  = string
    target_rule_set_id = string 
    request_header = list(object({
      operator = list(string)
      value = list(string)
    }))
    request_cookie = list(object({
      operator = list(string)
      value = list(string)
    }))
    request_uri = list(object({
      operator = list(string)
      value = list(string)
    }))
    request_query_param = list(object({
      operator = list(string)
      value = list(string)
    }))

  }))
}
#.............................................. Global Policy Rule .............................................#