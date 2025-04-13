locals {
    scope                                                     = var.scope
    project                                                   = var.project_id
    region                                                    = var.region
    security_policy                                           = var.security_policy

    priority                                                  = var.priority
    action                                                    = var.action
    preview                                                   = var.preview
    security_policy_rule_description                          = var.security_policy_rule_description
}

resource "google_compute_region_security_policy_rule" "rule" {
    provider                                                 = google-beta  
    count                                                    = local.scope == "regional" ? 1 : 0
    priority                                                 = local.priority
    action                                                   = local.action
    region                                                   = local.region
    security_policy                                          = local.security_policy
    description                                              = local.security_policy_rule_description
    preview                                                  = local.preview
    project                                                  = local.project
    dynamic "match" {             
        for_each                                             = var.match [*]
        content {            
            versioned_expr                                   = lookup(match.value,"versioned_expr",null)
            dynamic "config"{            
                for_each                                     = lookup(match.value,"config",[])
                content {            
                    src_ip_ranges                            = lookup(config.value, "src_ip_ranges",null)
                }            
            }            
        }            
    }           
    dynamic "network_match" {           
        for_each                                             = var.network_match[*]
        content {            
            src_ip_ranges                                    = network_match.value.src_ip_ranges
            dest_ip_ranges                                   = network_match.value.dest_ip_ranges
            ip_protocols                                     = network_match.value.ip_protocols
            src_ports                                        = network_match.value.src_ports
            dest_ports                                       = network_match.value.dest_ports
            src_region_codes                                 = network_match.value.src_region_codes
            src_asns                                         = network_match.value.src_asns
            dynamic "user_defined_fields"{           
                for_each                                     = lookup(network_match.value,"user_defined_fields",[])
                content {                            
                    name                                     = lookup(user_defined_fields.value , "name", null)
                    values                                   = lookup(user_defined_fields.value , "values",null)
                }            
             
            }
        }   
    }
}

/* resource "google_compute_security_policy_rule" "default" {
    provider                                                 = google-beta  
    count                                                    = local.scope == "global" ? 1 : 0
    priority                                                 = local.priority
    action                                                   = local.action
    security_policy                                          = local.security_policy
    description                                              = local.security_policy_rule_description
    preview                                                  = local.preview
    project                                                  = local.project
    dynamic "match"{
        for_each                                             = var.match [*]
        content {
            versioned_expr                                   = match.value.versioned_expr
            dynamic "expr"{
                for_each                                     = lookup(match.value,"expr",[])
                content {
                    expression                               = lookup(expr.value, "expression",null)
                }
            }
            dynamic "config"{
                for_each                                     = lookup(match.value,"config",[])
                content {
                    src_ip_ranges                            = lookup(config.value, "src_ip_ranges",null)
                }
            }
        }
    }
    dynamic "preconfigured_waf_config" {
        for_each                                             = var.preconfigured_waf_config [*]
        content {
            target_rule_set                                  = preconfigured_waf_config.value.target_rule_set
            target_rule_ids                                  = preconfigured_waf_config.value.target_ids
            dynamic "request_header"{
                for_each                                     = lookup(preconfigured_waf_config.value,"request_header",[])
                content {
                    operator                                 = lookup(request_header.value, "operator",null)
                    value                                    = lookup(request_header.value, "value",null)
                }
            }
            dynamic "request_cookie"{
                for_each                                     = lookup(preconfigured_waf_config.value,"request_cookie",[])
                content {
                    operator                                 = lookup(request_cookie.value, "operator",null)
                    value                                    = lookup(request_cookie.value, "value",null)
                }
            }
            dynamic "request_uri"{
                for_each                                     = lookup(preconfigured_waf_config.value,"request_uri",[])
                content {
                    operator                                 = lookup(request_uri.value, "operator",null)
                    value                                    = lookup(request_uri.value, "value",null)
                }
            }
            dynamic "request_query_param" {
                for_each                                     = lookup(preconfigured_waf_config.value,"request_query_param",[])
                content {
                    operator                                 = lookup(request_query_param.value, "operator",null)
                    value                                    = lookup(request_query_param.value, "value",null)
                }
            }
        }
    }
} */