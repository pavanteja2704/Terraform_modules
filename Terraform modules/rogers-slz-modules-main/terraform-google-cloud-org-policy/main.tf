/******************************************
  Organization policy, allow values (list constraint)
 *****************************************/
/* resource "google_organization_policy" "org_policy_list_allow_values" {
  count      = var.policy == "allow" ? 1 : 0
  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
} */

/******************************************
  Organization policy, deny all (list constraint)
 *****************************************/
/* resource "google_organization_policy" "org_policy_list_deny_all" {
  count      = var.policy == "deny" ? 1 : 0
  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    deny {
      all    = true
    }
  }
} */

resource "google_organization_policy" "policy" {
  org_id                            = var.org_id
  constraint                        = var.constraint
  version                           = var.policy_version

  dynamic "boolean_policy" {
    for_each                        = var.boolean_policy
    content {
      enforced                      = boolean_policy.value.enforced
    }
  }

  dynamic "list_policy" {
    for_each                        = var.list_policy
    content {
      dynamic "allow" {
        for_each                    = lookup(list_policy.value, "allow", [])
        content {
          all                       = allow.value.all
          values                    = allow.value.values
        }
      }
      dynamic "deny" {
        for_each                    = lookup(list_policy.value, "deny", [])
        content {
          all                       = deny.value.all
          values                    = deny.value.values
        }
      }

      suggested_value               = list_policy.value.suggested_value
      inherit_from_parent           = list_policy.value.inherit_from_parent
    }
  }

  dynamic "restore_policy" {
    for_each                        = var.restore_policy
    content {
      default                       = restore_policy.value.default
    }
  }
}