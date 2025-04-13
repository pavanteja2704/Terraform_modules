resource "google_compute_security_policy" "policy" {
  name                      = var.security_policy_name
  project                   = var.project_id
  type                      = var.policy_type
  rule {
    action                  = var.action_type
    priority                = var.action_priority
    match {
      versioned_expr        = var.policy_versioned_expr
      config {
        src_ip_ranges       = var.policy_src_ip_ranges
      }
    }
    description             = var.rule_description
  }

  /* rule {
    action                  = var.deny_action
    priority                = var.deny_action_priority
    match {
      versioned_expr        = var.deny_policy_versioned_expr
      config {
        src_ip_ranges       = var.deny_policy_src_ip_ranges
      }
    }
    description             = var.deny_rule_description
  }

  rule {
    action                  = var.default_action
    priority                = var.default_action_priority
    match {
      versioned_expr        = var.default_policy_versioned_expr
      config {
        src_ip_ranges       = var.default_policy_src_ip_ranges
      }
    }
    description             = var.default_rule_description
  } */
}
