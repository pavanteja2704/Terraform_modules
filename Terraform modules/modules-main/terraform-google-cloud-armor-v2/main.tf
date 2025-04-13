locals {
    scope                                                     = var.scope
    project                                                   = var.project_id
    region                                                    = var.region
    security_policy_name                                      = var.security_policy_name
    security_policy_description                               = var.security_policy_description
    security_policy_type                                      = var.security_policy_type
}

resource "google_compute_region_security_policy" "policy" {
    provider                                                  = google-beta  
    count                                                     = local.scope == "regional" ? 1 : 0
    project                                                   = local.project
    region                                                    = local.region
    name                                                      = local.security_policy_name
    description                                               = local.security_policy_description
    type                                                      = local.security_policy_type

    dynamic "ddos_protection_config" {
        for_each                                             = var.ddos_protection_config [*]
        content {
            ddos_protection                                  = ddos_protection_config.value.ddos_protection
        }
    }
    dynamic "user_defined_fields" {
        for_each                                             = var.user_defined_fields [*]
        content {
            name                                             = user_defined_fields.value.name
            base                                             = user_defined_fields.value.base
            offset                                           = user_defined_fields.value.offset
            size                                             = user_defined_fields.value.size
            mask                                             = user_defined_fields.value.mask
        }                                        
    }
}

resource "google_compute_security_policy" "policy" {
    provider                                                 = google-beta  
    count                                                    = local.scope == "global" ? 1 : 0
    project                                                  = local.project
    type                                                     = local.security_policy_type
    name                                                     = local.security_policy_name
    description                                              = local.security_policy_description
                    
                
    /* advanced_options_config {                         
        log_level                                           = var.security_policy_log_level
        json_parsing                                        = var.security_policy_json_parsing
    } */
        
    # --------------------------------- 
    # Default rules
    # --------------------------------- 
        dynamic "rule" {
            for_each                                         = var.security_policy_default_rules
            content {                    
                action                                       = rule.value.action
                priority                                     = rule.value.priority
                description                                  = rule.value.description
                preview                                      = rule.value.preview
                match {                  
                    versioned_expr                           = rule.value.versioned_expr
                    config {                     
                        src_ip_ranges                        = rule.value.src_ip_ranges
                    }                    
                }                    
            }                    
        }                    
                             
    # ---------------------------------                      
    # Throttling traffic rules                   
    # ---------------------------------                      
        dynamic "rule" {                     
            for_each                                         = var.security_policy_throttle_rules
            content {                    
                action                                       = rule.value.action
                priority                                     = rule.value.priority
                description                                  = rule.value.description
                preview                                      = rule.value.preview
                match {                  
                    versioned_expr                           = rule.value.versioned_expr
                    config {                     
                        src_ip_ranges                        = rule.value.src_ip_ranges
                    }                    
                }                    
                rate_limit_options {                     
                    conform_action                           = rule.value.conform_action
                    exceed_action                            = rule.value.exceed_action
                    enforce_on_key                           = rule.value.enforce_on_key
                    rate_limit_threshold {
                        count                                = rule.value.rate_limit_threshold_count
                        interval_sec                         = rule.value.rate_limit_threshold_interval_sec
                    }
                } 
            }
        }

    # --------------------------------- 
    # Country limitation
    # --------------------------------- 
        dynamic "rule" {
            for_each                                         = var.security_policy_countries_rules
            content {                    
                action                                       = rule.value.action
                priority                                     = rule.value.priority
                description                                  = rule.value.description
                preview                                      = rule.value.preview
                match {                  
                    expr {                   
                        expression                           = rule.value.expression
                    }                    
                }                    
            }                    
        }                    
            
    # ---------------------------------                      
    # OWASP rules                    
    # ---------------------------------                      
        dynamic "rule" {                     
            for_each                                         = var.security_policy_owasp_rules
            content {                    
                action                                       = rule.value.action
                priority                                     = rule.value.priority
                description                                  = rule.value.description
                preview                                      = rule.value.preview
                match {                  
                    expr {                   
                        expression                           = rule.value.expression
                    }                    
                }                    
            }
        }

    # --------------------------------- 
    # Custom Log4j rule
    # --------------------------------- 
        dynamic "rule" {
            for_each                                         = var.security_policy_cves_and_vulnerabilities_rules
            content {                    
                action                                       = rule.value.action
                priority                                     = rule.value.priority
                description                                  = rule.value.description
                preview                                      = rule.value.preview
                match {                  
                    expr {                   
                        expression                           = rule.value.expression
                    }
                }
            }
        }
}