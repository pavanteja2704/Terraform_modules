#...................................................... locals ..........................................................#

locals {
    scope                                                                   = var.scope
    project                                                                 = var.project_id
    region                                                                  = var.region
    proxy_type                                                              = var.target_proxy_type
    proxy_name                                                              = var.proxy_name
    proxy_description                                                       = var.proxy_description
    proxy_bind                                                              = var.proxy_bind
    http_keep_alive_timeout_sec                                             = var.http_keep_alive_timeout_sec
    certificate_manager_certificates                                        = var.certificate_manager_certificates
    ssl_certificates                                                        = var.ssl_certificates_id
    ssl_policy                                                              = var.ssl_policy
    load_balancing_scheme                                                   = var.load_balancing_scheme
    
    backend_type                                                            = var.backend_type
    backend_service_name                                                    = var.backend_service_name
    affinity_cookie_ttl_sec                                                 = var.affinity_cookie_ttl_sec
    backend_service_description                                             = var.backend_service_description
    port_name                                                               = var.port_name
    backend_service_protocol                                                = var.backend_service_protocol
    connection_draining_timeout_sec                                         = var.connection_draining_timeout_sec
    enable_cdn                                                              = var.enable_cdn
    health_checks                                                           = var.health_check_id
    edge_security_policy                                                    = var.edge_security_policy
    security_policy                                                         = var.security_policy
    session_affinity                                                        = var.session_affinity
    backend_service_timeout_sec                                             = var.backend_service_timeout_sec
    
    frontend_name                                                           = var.frontend_name
    frontend_description                                                    = var.frontend_description
    ip_address                                                              = var.ip_address
    ip_protocol                                                             = var.ip_protocol
    network                                                                 = var.network
    subnetwork                                                              = var.subnetwork
    port_range                                                              = var.port_range
    labels                                                                  = var.labels
    source_ip_ranges                                                        = var.source_ip_ranges
    ip_version                                                              = var.ip_version
    allow_psc_global_access                                                 = var.allow_psc_global_access
    no_automate_dns_zone                                                    = var.no_automate_dns_zone
    service_directory_registrations                                         = var.service_directory_registrations
}

#.................................................... Global URL Map ....................................................#

# Create url map
resource "google_compute_url_map" "default" {
    provider                                                                = google-beta
    name                                                                    = var.url_map_name
    default_service                                                         = local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
    description                                                             = var.url_map_description

    dynamic "header_action" {
        for_each                                                            = var.header_action
        content {
            dynamic "request_headers_to_add" {
                for_each                                                    = lookup(header_action.value, "request_headers_to_add", [])
                content {
                    header_name                                             = request_headers_to_add.value.header_name
                    header_value                                            = request_headers_to_add.value.header_value
                    replace                                                 = request_headers_to_add.value.replace
                }
            }
            request_headers_to_remove                                       = header_action.value.request_headers_to_remove

            dynamic "response_headers_to_add" {
                for_each                                                    = lookup(header_action.value, "response_headers_to_add", [])
                content {
                    header_name                                             = response_headers_to_add.value.header_name
                    header_value                                            = response_headers_to_add.value.header_value
                    replace                                                 = response_headers_to_add.value.replace
                }
            }
            response_headers_to_remove                                      = header_action.value.response_headers_to_remove
        }
    }

    dynamic "host_rule" {
        for_each                                                            = var.host_rule[*]
        content {
            description                                                     = host_rule.value.description
            hosts                                                           = host_rule.value.hosts
            path_matcher                                                    = host_rule.value.path_matcher
        }
    }

    dynamic "path_matcher" {
        for_each                                                            = var.path_matcher[*]
        content {
            default_service                                                 = default # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
            description                                                     = path_matcher.value.description

            dynamic "header_action" {
                for_each                                                    = lookup(path_matcher.value, "header_action", [])
                content {
                    dynamic "request_headers_to_add" {
                        for_each                                            = lookup(header_action.value, "request_headers_to_add", [])
                        content {
                            header_name                                     = request_headers_to_add.value.header_name
                            header_value                                    = request_headers_to_add.value.header_value
                            replace                                         = request_headers_to_add.value.replace
                        }
                    }
                    request_headers_to_remove                               = header_action.value.request_headers_to_remove

                    dynamic "response_headers_to_add" {
                        for_each                                            = lookup(header_action.value, "response_headers_to_add", [])
                        content {
                            header_name                                     = response_headers_to_add.value.header_name
                            header_value                                    = response_headers_to_add.value.header_value
                            replace                                         = response_headers_to_add.value.replace
                        }
                    }
                    response_headers_to_remove                              = header_action.value.response_headers_to_remove
                }
            }

            name                                                            = path_matcher.value.name

            dynamic "path_rule" {
                for_each                                                    = lookup(path_matcher.value, "path_rule", [])
                content {
                    service                                                 = path_rule.value.service
                    paths                                                   = path_rule.value.paths
                    dynamic "route_action" {
                        for_each                                            = lookup(path_rule.value, "route_action", [])
                        content {
                            dynamic "cors_policy" {
                                for_each                                    = lookup(route_action.value, "cors_policy", [])
                                content {
                                    allow_credentials                       = cors_policy.value.allow_credentials
                                    allow_headers                           = cors_policy.value.allow_headers
                                    allow_methods                           = cors_policy.value.allow_methods
                                    allow_origin_regexes                    = cors_policy.value.allow_origin_regexes
                                    allow_origins                           = cors_policy.value.allow_origins
                                    disabled                                = cors_policy.value.disabled
                                    expose_headers                          = cors_policy.value.expose_headers
                                    max_age                                 = cors_policy.value.max_age
                                }
                            }

                            dynamic "fault_injection_policy" {
                                for_each                                    = lookup(route_action.value, "fault_injection_policy", [])
                                content {
                                    dynamic "abort" {
                                        for_each                            = lookup(fault_injection_policy.value, "abort", [])
                                        content {
                                            http_status                     = abort.value.http_status
                                            percentage                      = abort.value.percentage
                                        }
                                    }
                                    dynamic "delay" {
                                        for_each                            = lookup(fault_injection_policy.value, "delay", [])
                                        content {
                                            dynamic "fixed_delay" {
                                                for_each                    = lookup(delay.value, "fixed_delay", [])
                                                content {
                                                    nanos                   = fixed_delay.value.nanos
                                                    seconds                 = fixed_delay.value.seconds
                                                }
                                            }
                                            percentage                      = delay.value.percentage
                                        }
                                    }
                                }
                            }

                            dynamic "request_mirror_policy" {
                                for_each                                    = lookup(default_route_action.value, "request_mirror_policy", [])
                                content {
                                    backend_service                         = default # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
                                }
                            }

                             dynamic "retry_policy" {
                                for_each                                    = lookup(default_route_action.value, "retry_policy", [])
                                content {
                                    num_retries                             = retry_policy.value.num_retries

                                    dynamic "per_try_timeout" {
                                        for_each                            = lookup(retry_policy.value, "per_try_timeout", [])
                                        content {
                                            nanos                           = per_try_timeout.value.nanos
                                            seconds                         = per_try_timeout.value.seconds
                                        }
                                    }

                                    retry_conditions                        = retry_policy.value.retry_conditions
                                }
                            }

                            dynamic "timeout" {
                                for_each                                    = lookup(default_route_action.value, "timeout", [])
                                content {
                                    nanos                                   = timeout.value.nanos
                                    seconds                                 = timeout.value.seconds
                                }
                            }

                            dynamic "url_rewrite" {
                                for_each                                    = lookup(default_route_action.value, "url_rewrite", [])
                                content {
                                    host_rewrite                            = url_rewrite.value.host_rewrite
                                    path_prefix_rewrite                     = url_rewrite.value.path_prefix_rewrite
                                }
                            }

                            dynamic "weighted_backend_services" {
                                for_each                                    = lookup(route_action.value, "weighted_backend_services", [])
                                content {
                                    backend_service                         = default # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id

                                    dynamic "header_action" {
                                        for_each                            = lookup(weighted_backend_services.value, "header_action", [])
                                        content {
                                            dynamic "request_headers_to_add" {
                                                for_each                    = lookup(header_action.value, "request_headers_to_add", [])
                                                content {
                                                    header_name             = request_headers_to_add.value.header_name
                                                    header_value            = request_headers_to_add.value.header_value
                                                    replace                 = request_headers_to_add.value.replace
                                                }
                                            }
                                            request_headers_to_remove       = header_action.value.request_headers_to_remove

                                            dynamic "response_headers_to_add" {
                                                for_each                    = lookup(header_action.value, "response_headers_to_add", [])
                                                content {
                                                    header_name             = response_headers_to_add.value.header_name
                                                    header_value            = response_headers_to_add.value.header_value
                                                    replace                 = response_headers_to_add.value.replace
                                                }
                                            }
                                            response_headers_to_remove      = header_action.value.response_headers_to_remove
                                        }
                                    }
                                    weight                                  = weighted_backend_services.value.weight
                                }
                            }
                        }
                    }

                    dynamic "url_redirect" {
                        for_each                                            = lookup(path_rule.value, "url_redirect", [])
                        content {
                            host_redirect                                   = url_redirect.value.host_redirect
                            https_redirect                                  = url_redirect.value.https_redirect
                            path_redirect                                   = url_redirect.value.path_redirect
                            prefix_redirect                                 = url_redirect.value.prefix_redirect
                            redirect_response_code                          = url_redirect.value.redirect_response_code
                            strip_query                                     = url_redirect.value.strip_query
                        }
                    }
                }
            }

            dynamic "route_rules" {
                for_each                                                    = lookup(path_matcher.value, "route_rules", [])
                content {
                    priority                                                = route_rules.value.priority
                    service                                                 = route_rules.value.service                               
                    dynamic "header_action" {
                        for_each                                            = lookup(route_rules.value, "header_action", [])
                        content {
                            dynamic "request_headers_to_add" {
                                for_each                                    = lookup(header_action.value, "request_headers_to_add", [])
                                content {
                                    header_name                             = request_headers_to_add.value.header_name
                                    header_value                            = request_headers_to_add.value.header_value
                                    replace                                 = request_headers_to_add.value.replace
                                }
                            }
                            request_headers_to_remove                       = header_action.value.request_headers_to_remove

                            dynamic "response_headers_to_add" {
                                for_each                                    = lookup(header_action.value, "response_headers_to_add", [])
                                content {
                                    header_name                             = response_headers_to_add.value.header_name
                                    header_value                            = response_headers_to_add.value.header_value
                                    replace                                 = response_headers_to_add.value.replace
                                }
                            }
                            response_headers_to_remove                      = header_action.value.response_headers_to_remove
                        }
                    }

                    dynamic "match_rules" {
                        for_each                                            = lookup(route_rules.value, "match_rules", [])
                        content {
                            full_path_match                                 = match_rules.value.full_path_match
                            dynamic "header_matches" {
                                for_each                                    = lookup(match_rules.value, "header_matches", [])
                                content {
                                    exact_match                             = header_matches.value.exact_match
                                    header_name                             = header_matches.value.header_name
                                    invert_match                            = header_matches.value.invert_match 
                                    prefix_match                            = header_matches.value.prefix_match
                                    present_match                           = header_matches.value.present_match

                                    dynamic "range_match" {
                                        for_each                            = lookup(header_matches.value, "range_match", [])
                                        content {
                                            range_end                       = range_match.value.range_end
                                            range_start                     = range_match.value.range_start
                                        }
                                    }
                                    regex_match                             = header_matches.value.regex_match
                                    suffix_match                            = header_matches.value.suffix_match
                                }
                            }
                            ignore_case                                     = match_rules.value.ignore_case
                            
                            dynamic "metadata_filters" {
                                for_each                                    = lookup(match_rules.value, "filter_labels", [])
                                content {
                                    dynamic "filter_labels" {
                                        for_each                            = lookup(metadata_filters.value, "filter_labels", [])
                                        content {
                                            name                            = filter_labels.value.name
                                            value                           = filter_labels.value.value 
                                        }
                                    }
                                    filter_match_criteria                   = metadata_filters.value.filter_match_criteria
                                }
                            }
                            prefix_match                                    = match_rules.value.prefix_match

                            dynamic "query_parameter_matches" {
                                for_each                                    = lookup(match_rules.value, "query_parameter_matches", [])
                                content {
                                    exact_match                             = query_parameter_matches.value.exact_match
                                    name                                    = query_parameter_matches.value.name
                                    present_match                           = query_parameter_matches.value.present_match
                                    regex_match                             = query_parameter_matches.value.regex_match
                                }
                            }
                            regex_match                                     = match_rules.value.regex_match
                            path_template_match                             = match_rules.value.path_template_match
                        }
                    }

                    dynamic "route_action" {
                        for_each                                            = lookup(route_rules.value, "route_action", [])
                        content {
                            dynamic "cors_policy" {
                                for_each                                    = lookup(route_action.value, "cors_policy", [])
                                content {
                                    allow_credentials                       = cors_policy.value.allow_credentials
                                    allow_headers                           = cors_policy.value.allow_headers
                                    allow_methods                           = cors_policy.value.allow_methods
                                    allow_origin_regexes                    = cors_policy.value.allow_origin_regexes
                                    allow_origins                           = cors_policy.value.allow_origins
                                    disabled                                = cors_policy.value.disabled
                                    expose_headers                          = cors_policy.value.expose_headers
                                    max_age                                 = cors_policy.value.max_age
                                }
                            }
                            dynamic "fault_injection_policy" {
                                for_each                                    = lookup(route_action.value, "fault_injection_policy", [])
                                content {
                                    dynamic "abort" {
                                        for_each                            = lookup(fault_injection_policy.value, "abort", [])
                                        content {
                                            http_status                     = abort.value.http_status
                                            percentage                      = abort.value.percentage
                                        }
                                    }
                                    dynamic "delay" {
                                        for_each                            = lookup(fault_injection_policy.value, "delay", [])
                                        content {
                                            dynamic "fixed_delay" {
                                                for_each                    = lookup(delay.value, "fixed_delay", [])
                                                content {
                                                    nanos                   = fixed_delay.value.nanos
                                                    seconds                 = fixed_delay.value.seconds
                                                }
                                            }
                                            percentage                      = delay.value.percentage
                                        }
                                    }
                                }
                            }
                            dynamic "request_mirror_policy" {
                                for_each                                    = lookup(route_action.value, "request_mirror_policy", [])
                                content {
                                    backend_service                         = request_mirror_policy.value.backend_service
                                }
                            }
                            dynamic "retry_policy" {
                                for_each                                    = lookup(route_action.value, "retry_policy", [])
                                content {
                                    num_retries                             = retry_policy.value.num_retries
                                    dynamic "per_try_timeout" {
                                        for_each                            = lookup(retry_policy.value, "per_try_timeout", [])
                                        content {
                                            nanos                           = per_try_timeout.value.nanos
                                            seconds                         = per_try_timeout.value.seconds
                                        }
                                    }
                                    retry_conditions                        = retry_policy.value.retry_conditions
                                }
                            }
                            dynamic "timeout" {
                                for_each                                    = lookup(route_action.value, "timeout", [])
                                content {
                                    nanos                                   = timeout.value.nanos
                                    seconds                                 = timeout.value.seconds
                                }
                            }
                            dynamic "url_rewrite" {
                                for_each                                    = lookup(route_action.value, "url_rewrite", [])
                                content {
                                    host_rewrite                            = url_rewrite.value.host_rewrite
                                    path_prefix_rewrite                     = url_rewrite.value.path_prefix_rewrite
                                }
                            }
                            dynamic "weighted_backend_services" {
                                for_each                                    = lookup(route_action.value, "weighted_backend_services", [])
                                content {
                                    backend_service                         = weighted_backend_services.value.backend_service

                                    dynamic "header_action" {
                                        for_each                            = lookup(weighted_backend_services.value, "header_action", [])
                                        content {
                                            dynamic "request_headers_to_add" {
                                                for_each                    = lookup(header_action.value, "request_headers_to_add", [])
                                                content {
                                                    header_name             = request_headers_to_add.value.header_name
                                                    header_value            = request_headers_to_add.value.header_value
                                                    replace                 = request_headers_to_add.value.replace
                                                }
                                            }
                                            request_headers_to_remove       = header_action.value.request_headers_to_remove

                                            dynamic "response_headers_to_add" {
                                                for_each                    = lookup(header_action.value, "response_headers_to_add", [])
                                                content {
                                                    header_name             = response_headers_to_add.value.header_name
                                                    header_value            = response_headers_to_add.value.header_value
                                                    replace                 = response_headers_to_add.value.replace
                                                }
                                            }
                                            response_headers_to_remove      = header_action.value.response_headers_to_remove
                                        }
                                    }
                                    weight                                  = weighted_backend_services.value.weight
                                }
                            }
                        }
                    }

                    dynamic "url_redirect" {
                        for_each                                            = lookup(route_rules.value, "url_redirect", [])
                        content {
                            host_redirect                                   = url_redirect.value.host_redirect
                            https_redirect                                  = url_redirect.value.https_redirect
                            path_redirect                                   = url_redirect.value.path_redirect
                            prefix_redirect                                 = url_redirect.value.prefix_redirect
                            redirect_response_code                          = url_redirect.value.redirect_response_code
                            strip_query                                     = url_redirect.value.strip_query
                        }
                    }
                }
            }

            dynamic "default_url_redirect" {
                for_each                                                    = lookup(path_matcher.value, "default_url_redirect", [])
                content {
                    host_redirect                                           = default_url_redirect.value.host_redirect
                    https_redirect                                          = default_url_redirect.value.https_redirect
                    path_redirect                                           = default_url_redirect.value.path_redirect
                    prefix_redirect                                         = default_url_redirect.value.prefix_redirect
                    redirect_response_code                                  = default_url_redirect.value.redirect_response_code
                    strip_query                                             = default_url_redirect.value.strip_query
                }
            }

            dynamic "default_route_action" {
                for_each                                                    = lookup(path_matcher.value, "default_route_action", [])
                content {
                    dynamic "weighted_backend_services" {
                        for_each                                            = lookup(default_route_action.value, "weighted_backend_services", [])
                        content {
                            backend_service                                 = weighted_backend_services.value.backend_service

                            dynamic "header_action" {
                                for_each                                    = lookup(weighted_backend_services.value, "header_action", [])
                                content {
                                    dynamic "request_headers_to_add" {
                                        for_each                            = lookup(header_action.value, "request_headers_to_add", [])
                                        content {
                                            header_name                     = request_headers_to_add.value.header_name
                                            header_value                    = request_headers_to_add.value.header_value
                                            replace                         = request_headers_to_add.value.replace
                                        }
                                    }
                                    request_headers_to_remove               = header_action.value.request_headers_to_remove

                                    dynamic "response_headers_to_add" {
                                        for_each                            = lookup(header_action.value, "response_headers_to_add", [])
                                        content {
                                            header_name                     = response_headers_to_add.value.header_name
                                            header_value                    = response_headers_to_add.value.header_value
                                            replace                         = response_headers_to_add.value.replace
                                        }
                                    }
                                    response_headers_to_remove              = header_action.value.response_headers_to_remove
                                }
                            }
                            weight                                          = weighted_backend_services.value.weight
                        }
                    }

                    dynamic "url_rewrite" {
                        for_each                                            = lookup(default_route_action.value, "url_rewrite", [])
                        content {
                            host_rewrite                                    = url_rewrite.value.host_rewrite
                            path_prefix_rewrite                             = url_rewrite.value.path_prefix_rewrite
                        }
                    }

                    dynamic "timeout" {
                        for_each                                            = lookup(default_route_action.value, "timeout", [])
                        content {
                            nanos                                           = timeout.value.nanos
                            seconds                                         = timeout.value.seconds
                        }
                    }

                    dynamic "retry_policy" {
                        for_each                                            = lookup(default_route_action.value, "retry_policy", [])
                        content {
                            num_retries                                     = retry_policy.value.num_retries

                            dynamic "per_try_timeout" {
                                for_each                                    = lookup(retry_policy.value, "per_try_timeout", [])
                                content {
                                    nanos                                   = per_try_timeout.value.nanos
                                    seconds                                 = per_try_timeout.value.seconds
                                }
                            }

                            retry_conditions                                = retry_policy.value.retry_conditions
                        }
                    }

                    dynamic "request_mirror_policy" {
                        for_each                                            = lookup(default_route_action.value, "request_mirror_policy", [])
                        content {
                            backend_service                                 = request_mirror_policy.value.backend_service
                        }
                    }

                    dynamic "cors_policy" {
                        for_each                                            = lookup(default_route_action.value, "cors_policy", [])
                        content {
                            allow_credentials                               = cors_policy.value.allow_credentials
                            allow_headers                                   = cors_policy.value.allow_headers
                            allow_methods                                   = cors_policy.value.allow_methods
                            allow_origin_regexes                            = cors_policy.value.allow_origin_regexes
                            allow_origins                                   = cors_policy.value.allow_origins
                            disabled                                        = cors_policy.value.disabled
                            expose_headers                                  = cors_policy.value.expose_headers
                            max_age                                         = cors_policy.value.max_age
                        }
                    }

                    dynamic "fault_injection_policy" {
                        for_each                                            = lookup(default_route_action.value, "fault_injection_policy", [])
                        content {
                            dynamic "abort" {
                                for_each                                    = lookup(fault_injection_policy.value, "abort", [])
                                content {
                                    http_status                             = abort.value.http_status
                                    percentage                              = abort.value.percentage
                                }
                            }
                            dynamic "delay" {
                                for_each                                    = lookup(fault_injection_policy.value, "delay", [])
                                content {
                                    dynamic "fixed_delay" {
                                        for_each                            = lookup(delay.value, "fixed_delay", [])
                                        content {
                                            nanos                           = fixed_delay.value.nanos
                                            seconds                         = fixed_delay.value.seconds
                                        }
                                    }
                                    percentage                              = delay.value.percentage
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    dynamic "test" {
        for_each                                                            = var.test[*]
        content {
            description                                                     = test.value.description
            host                                                            = test.value.hosts
            path                                                            = test.value.path
            service                                                         = default # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
        }
    }

    dynamic "default_url_redirect" {
        for_each                                                            = var.default_url_redirect[*]
        content {
            host_redirect                                                   = default_url_redirect.value.host_redirect
            https_redirect                                                  = default_url_redirect.value.https_redirect
            path_redirect                                                   = default_url_redirect.value.path_redirect
            prefix_redirect                                                 = default_url_redirect.value.prefix_redirect
            redirect_response_code                                          = default_url_redirect.value.redirect_response_code
            strip_query                                                     = default_url_redirect.value.strip_query
        }
    }

    dynamic "default_route_action" {
        for_each                                                            = var.default_route_action[*]
        content {
            dynamic "weighted_backend_services" {
                for_each                                                    = lookup(default_route_action.value, "weighted_backend_services", [])
                content {
                    backend_service                                         = weighted_backend_services.value.backend_service

                    dynamic "header_action" {
                        for_each                                            = lookup(weighted_backend_services.value, "header_action", [])
                        content {
                            dynamic "request_headers_to_add" {
                                for_each                                    = lookup(header_action.value, "request_headers_to_add", [])
                                content {
                                    header_name                             = request_headers_to_add.value.header_name
                                    header_value                            = request_headers_to_add.value.header_value
                                    replace                                 = request_headers_to_add.value.replace
                                }
                            }
                            request_headers_to_remove                       = header_action.value.request_headers_to_remove

                            dynamic "response_headers_to_add" {
                                for_each                                    = lookup(header_action.value, "response_headers_to_add", [])
                                content {
                                    header_name                             = response_headers_to_add.value.header_name
                                    header_value                            = response_headers_to_add.value.header_value
                                    replace                                 = response_headers_to_add.value.replace
                                }
                            }
                            response_headers_to_remove                      = header_action.value.response_headers_to_remove
                        }
                    }
                    weight                                                  = weighted_backend_services.value.weight
                }
            }

            dynamic "url_rewrite" {
                for_each                                                    = lookup(default_route_action.value, "url_rewrite", [])
                content {
                    host_rewrite                                            = url_rewrite.value.host_rewrite
                    path_prefix_rewrite                                     = url_rewrite.value.path_prefix_rewrite
                }
            }

            dynamic "timeout" {
                for_each                                                    = lookup(default_route_action.value, "timeout", [])
                content {
                    nanos                                                   = timeout.value.nanos
                    seconds                                                 = timeout.value.seconds
                }
            }

            dynamic "retry_policy" {
                for_each                                                    = lookup(default_route_action.value, "retry_policy", [])
                content {
                    num_retries                                             = retry_policy.value.num_retries

                    dynamic "per_try_timeout" {
                        for_each                                            = lookup(retry_policy.value, "per_try_timeout", [])
                        content {
                            nanos                                           = per_try_timeout.value.nanos
                            seconds                                         = per_try_timeout.value.seconds
                        }
                    }

                    retry_conditions                                        = retry_policy.value.retry_conditions
                }
            }

            dynamic "request_mirror_policy" {
                for_each                                                    = lookup(default_route_action.value, "request_mirror_policy", [])
                content {
                    backend_service                                         = request_mirror_policy.value.backend_service
                }
            }

            dynamic "cors_policy" {
                for_each                                                    = lookup(default_route_action.value, "cors_policy", [])
                content {
                    allow_credentials                                       = cors_policy.value.allow_credentials
                    allow_headers                                           = cors_policy.value.allow_headers
                    allow_methods                                           = cors_policy.value.allow_methods
                    allow_origin_regexes                                    = cors_policy.value.allow_origin_regexes
                    allow_origins                                           = cors_policy.value.allow_origins
                    disabled                                                = cors_policy.value.disabled
                    expose_headers                                          = cors_policy.value.expose_headers
                    max_age                                                 = cors_policy.value.max_age
                }
            }

            dynamic "fault_injection_policy" {
                for_each                                                    = lookup(default_route_action.value, "fault_injection_policy", [])
                content {
                    dynamic "abort" {
                        for_each                                            = lookup(fault_injection_policy.value, "abort", [])
                        content {
                            http_status                                     = abort.value.http_status
                            percentage                                      = abort.value.percentage
                        }
                    }
                    dynamic "delay" {
                        for_each                                            = lookup(fault_injection_policy.value, "delay", [])
                        content {
                            dynamic "fixed_delay" {
                                for_each                                    = lookup(delay.value, "fixed_delay", [])
                                content {
                                    nanos                                   = fixed_delay.value.nanos
                                    seconds                                 = fixed_delay.value.seconds
                                }
                            }
                            percentage                                      = delay.value.percentage
                        }
                    }
                }
            }
        }
    }
    project                                                                 = var.url_map_project_id != null ? local.project : var.url_map_project_id
    depends_on                                                              = [ google_compute_region_backend_service.default ]
}

#................................................. Region HTTP Proxy ....................................................#

resource "google_compute_region_target_http_proxy" "default"{
    count                                                                   = local.scope == "regional" && local.proxy_type == "http" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = google_compute_url_map.default.id
    description                                                             = local.proxy_description 
    region                                                                  = local.region
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#................................................ Region HTTPS Proxy ....................................................#

resource "google_compute_region_target_https_proxy" "default"{
    count                                                                   = local.scope == "regional" && local.proxy_type == "https" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = google_compute_url_map.default.id
    description                                                             = local.proxy_description 
    certificate_manager_certificates                                        = local.certificate_manager_certificates
    ssl_certificates                                                        = local.ssl_certificates
    ssl_policy                                                              = local.ssl_policy
    region                                                                  = local.region
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#...................................................... HTTP Proxy ......................................................#

resource "google_compute_target_http_proxy" "default" {
    count                                                                   = local.scope == "global" && local.proxy_type == "http" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = google_compute_url_map.default.id
    description                                                             = local.proxy_description
    proxy_bind                                                              = local.proxy_bind
    http_keep_alive_timeout_sec                                             = local.http_keep_alive_timeout_sec
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#..................................................... HTTPs Proxy ......................................................#

resource "google_compute_target_https_proxy" "default" {
    count                                                                   = local.scope == "global" && local.proxy_type == "https" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = google_compute_url_map.default.id
    description                                                             = local.proxy_description
    quic_override                                                           = var.quic_override
    certificate_manager_certificates                                        = local.certificate_manager_certificates
    ssl_certificates                                                        = local.ssl_certificates
    certificate_map                                                         = var.certificate_map
    ssl_policy                                                              = local.ssl_policy
    proxy_bind                                                              = local.proxy_bind
    http_keep_alive_timeout_sec                                             = local.http_keep_alive_timeout_sec
    server_tls_policy                                                       = var.server_tls_policy
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#.................................................... Region Backend ....................................................#

resource "google_compute_region_backend_service" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "regional" ? 1 : 0
    name                                                                    = local.backend_service_name
    affinity_cookie_ttl_sec                                                 = local.affinity_cookie_ttl_sec
    region                                                                  = local.region
    project                                                                 = var.backend_project_id != null ? local.project : var.backend_project_id
    connection_draining_timeout_sec                                         = local.connection_draining_timeout_sec
    enable_cdn                                                              = local.enable_cdn
    health_checks                                                           = local.health_checks
    description                                                             = local.backend_service_description
    port_name                                                               = local.port_name
    protocol                                                                = local.backend_service_protocol
    security_policy                                                         = local.security_policy
    session_affinity                                                        = local.session_affinity
    timeout_sec                                                             = local.backend_service_timeout_sec
    network                                                                 = var.backend_service_network
    load_balancing_scheme                                                   = local.load_balancing_scheme
    locality_lb_policy                                                      = var.locality_lb_policy

    dynamic "backend" {
        for_each                                                            = var.backend[*]
        content {
            balancing_mode                                                  = lookup(backend.value, "balancing_mode" , "")
            capacity_scaler                                                 = lookup(backend.value, "capacity_scaler" , "")
            description                                                     = lookup(backend.value, "description" , "")
            failover                                                        = lookup(backend.value, "failover", "")
            group                                                           = lookup(backend.value, "group", "")
            max_connections                                                 = lookup(backend.value, "max_connections" , "")
            max_connections_per_instance                                    = lookup(backend.value, "max_connections_per_instance" , "")
            max_connections_per_endpoint                                    = lookup(backend.value, "max_connections_per_endpoint" , "")
            max_rate                                                        = lookup(backend.value, "max_rate", "")
            max_rate_per_instance                                           = lookup(backed.value , "max_rate_per_instance" , "")
            max_rate_per_endpoint                                           = lookup(back.value, "max_rate_per_endpoint" , "")
            max_utilization                                                 = lookup(backed.value, "max_utilization", "")
        }
      
    }
    dynamic "circuit_breakers" {
        for_each                                                            = var.circuit_breakers
        content {
            dynamic "connect_timeout"   {
                for_each                                                    = lookup(circuit_breakers.value, "connect_timeout" , "")
                content {
                    seconds                                                 = lookup(connect_timeout.value, "seconds" , "")
                    nanos                                                   = lookup(connect_timeout.value, "nanos" , "")
                }
            }
            max_requests_per_connection                                     = lookup(circuit_breakers.value, "max_requests_per_connection", "")
            max_connections                                                 = lookup(circuit_breakers.value, "max_connections", "")
            max_pending_requests                                            = lookup(circuit_breakers.value, "max_pending_requests", "")
            max_requests                                                    = lookup(circuit_breakers.value, "max_requests", "")
            max_retries                                                     = lookup(circuit_breakers.value, "max_retries", "")
        }
      
    }
    dynamic "consistent_hash" {
        for_each                                                            = var.consistent_hash
        content {
            dynamic "http_cookie" {
           
            for_each                                                        = lookup(consistent_hash.value, "http_cookie", "")
            content {
                dynamic "ttl" {
                    for_each                                                = lookup(http_cookie.value, "ttl", "")
                    content {
                        seconds                                             = lookup(ttl.value, "seconds" , "")
                        nanos                                               = lookup(ttl.value, "nanos", "")
                    }
                }
            name                                                            = lookup(http_cookie.value, "name", "")
            path                                                            = lookup(http_cookie.value, "path", "")
           }
         }
       }
      
    }
    dynamic "cdn_policy" {
        for_each                                                            = var.cdn_policy
        content {
            dynamic "cache_key_policy" {
                for_each                                                    = lookup(cdn_policy, "cache_key_policy", [])
                content {
                include_host                                                = lookup(cache_key_policy.value, "include_host", "")
                include_protocol                                            = lookup(cache_key_policy.value,"include_protocol", "")
                include_query_string                                        = lookup(cache_key_policy.value,"include_query_string", "")
                query_string_blacklist                                      = lookup(cache_key_policy.value,"query_string_blacklist", "")
                query_string_whitelist                                      = lookup(cache_key_policy.value,"query_string_whitelist", "")
                include_named_cookies                                       = lookup(cache_key_policy.value,"include_named_cookies", "")
                }
            }
        }
      
    }
    
    dynamic "failover_policy" {
        for_each                                                            = var.failover_policy
        content {
            disable_connection_drain_on_failover                            = lookup(failover_policy.value, "disable_connection_drain_on_failover", "")
            drop_traffic_if_unhealthy                                       = lookup(failover_policy.value, "drop_traffic_if_unhealthy", "")
            failover_ratio                                                  = lookup(failover_policy.value, "drop_traffic_if_unhealthy", "")
        }
    }
    
    dynamic "iap" {
        for_each                                                            = var.iap [*]
        content {
            oauth2_client_id                                                = lookup(iap.value, "oauth2_client_id", "")
            oauth2_client_secret                                            = lookup(iap.value, "oauth2_client_secret", "")
            oauth2_client_secret_sha256                                     = lookup(iap.value, "oauth2_client_secret_sha256", "")
        }
      
    }
    
    dynamic "outlier_detection" {
        for_each                                                            = var.outlier_detection [*]
        content {
            dynamic "base_ejection_time" {
                for_each                                                    = lookup(outlier_detection.value, "base_ejection_time", "")
                content {
                    seconds                                                 = lookup(base_ejection_time.value, "seconds","")
                    nanos                                                   = lookup(base_ejection_time.value, "nanos" , "")
                }
            }
            consecutive_errors                                              = lookup(outlier_detection.value, "consecutive_errors", "")
            consecutive_gateway_failure                                     = lookup(outlier_detection.value,"consecutive_gateway_failure", "")
            enforcing_consecutive_errors                                    = lookup(outlier_detection.value,"enforcing_consecutive_errors", "")
            enforcing_consecutive_gateway_failure                           = lookup(outlier_detection.value,"enforcing_consecutive_gateway_failure", "")
            enforcing_success_rate                                          = lookup(outlier_detection.value,"enforcing_success_rate", "")
            dynamic "interval" {
                for_each                                                    = lookup(outlier_detection.value, "interval", "")
                content {
                    seconds                                                 = lookup(interval.value, "seconds","")
                    nanos                                                   = lookup (interval.value, "nano" , "")
                }
            }
            max_ejection_percent                                            = lookup(outlier_detection.value, "max_ejection_percent", "")
            success_rate_minimum_hosts                                      = lookup(outlier_detection.value, "success_rate_minimum_hosts", "")
            success_rate_request_volume                                     = lookup(outlier_detection.value, "success_rate_request_volume" , "")
            success_rate_stdev_factor                                       = lookup(outlier_detection.value, "success_rate_stdev_factor", "")
        }  
    }
    
    dynamic "connection_tracking_policy" {
        for_each                                                            = var.connection_tracking_policy [*]
        content {
            idle_timeout_sec                                                = lookup(connection_tracking_policy.value, "idle_timeout_sec", "")
            tracking_mode                                                   = lookup(connection_tracking_policy.value, "tracking_mode", "")
            connection_persistence_on_unhealthy_backends                    = lookup(connection_tracking_policy.value, "connection_persistence_on_unhealthy_backends", "")
            enable_strong_affinity                                          = lookup(connection_tracking_policy, "enable_strong_affinity", "")
        }
    }
    
    dynamic "log_config" {
        for_each                                                            = var.log_config [*]
        content {
            enable                                                          = lookup(log_config.value, "enable", "")
            sample_rate                                                     = lookup(log_config.value,"sample", "")
        }
    }
    
    dynamic "subsetting" {
        for_each                                                            = var.subsetting
        content {
            policy                                                          = lookup(subsetting.value, "policy", "")
        }
    } 
}

#..................................................... Backend MIG ......................................................#

resource "google_compute_backend_service" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "global" ? 1 : 0
    project                                                                 = var.backend_project_id != null ? local.project : var.backend_project_id
    name                                                                    = local.backend_service_name
    description                                                             = local.backend_service_description    
    health_checks                                                           = local.health_checks
    load_balancing_scheme                                                   = local.load_balancing_scheme
    protocol                                                                = local.backend_service_protocol
    timeout_sec                                                             = local.backend_service_timeout_sec
    security_policy                                                         = local.security_policy
    edge_security_policy                                                    = local.edge_security_policy
    enable_cdn                                                              = local.enable_cdn
    affinity_cookie_ttl_sec                                                 = local.affinity_cookie_ttl_sec
    dynamic "backend" {
        for_each                                                            = var.backend [*]
        content {
            balancing_mode                                                  = lookup(backend.value, "balancing_mode", "")
            capacity_scaler                                                 = lookup(backend.value, "capacity_scaler", "")
            description                                                     = lookup(backend.value, "description","")
            group                                                           = lookup(backend.value, "group","")
            max_connections                                                 = lookup(backend.value, "max_connections" , "")
            max_connections_per_instance                                    = lookup(backend.value, "max_connections_per_instance", "")
            max_connections_per_endpoint                                    = lookup(backend.value, "max_connections_per_endpoint","")
            max_rate                                                        = lookup(backend.value, "max_rate","")
            max_rate_per_instance                                           = lookup(backend.value, "max_rate_per_instance","")
            max_rate_per_endpoint                                           = lookup(backend.value, "max_rate_per_endpoint", "")
            max_utilization                                                 = lookup(backend.value, "max_utilization","")
        }
    }
    dynamic "circuit_breakers" {
        for_each                                                            = var.circuit_breakers [*]
        content {
            dynamic "connect_timeout"   {
                for_each                                                    = lookup(circuit_breakers.value, "connect_timeout" , "")
                content {
                    seconds                                                 = lookup(connect_timeout.value, "seconds" , "")
                    nanos                                                   = lookup(connect_timeout.value, "nanos" , "")
                }
            }      
            max_requests_per_connection                                     = lookup(circuit_breakers.value, "max_requests_per_connection" ,"")
            max_connections                                                 = lookup(circuit_breakers.value, "max_connections","")
            max_pending_requests                                            = lookup(circuit_breakers.value, "max_pending_requests", "")
            max_requests                                                    = lookup(circuit_breakers.value, "max_requests", null)
            max_retries                                                     = lookup(circuit_breakers.value, "max_retries", "")
        }
    }
    compression_mode                                                        = var.compression_mode
    dynamic "consistent_hash" {
        for_each                                                            = var.consistent_hash [*]
        content {
            dynamic "http_cookie" {
                for_each                                                    = lookup(consistent_hash.value, "http_cookie", "")
                content {
                    dynamic "ttl" {
                        for_each                                            = lookup(http_cookie.value, "ttl", "")
                        content {
                        seconds                                             = lookup(ttl.value, "seconds", "")
                        nanos                                               = lookup(ttl.value, "nanos", "")
                        }
                    }
                }
            }
            http_header_name                                                = lookup(consistent_hash.value, "http_header_name", "")
            minimum_ring_size                                               = lookup(consistent_hash.value, "minimum_ring_size", "")
        }
    }
    dynamic "cdn_policy" {
        for_each                                                            = var.cdn_policy [*]
        content {
            dynamic "cache_key_policy" {
                for_each                                                    = lookup(cdn_policy.value, "cache_key_policy", "")
                content {
                  include_host                                              = lookup(cdn_policy.value, "include_host", null)
                  include_protocol                                          = lookup(cdn_policy.value, "include_protocol", null)
                  include_query_string                                      = lookup(cdn_policy.value, "include_query_string", null)
                  query_string_blacklist                                    = lookup(cdn_policy.value, "query_string_blacklist",null)
                  query_string_whitelist                                    = lookup(cdn_policy.value, "query_string_whitelist", null)
                  include_http_headers                                      = lookup(cdn_policy.value, "include_http_headers" , null)
                  include_named_cookies                                     = lookup(cdn_policy.value, "include_named_cookies" , null)
                }
            }
        }
      
    }
    connection_draining_timeout_sec                                         = local.connection_draining_timeout_sec
    custom_request_headers                                                  = var.custom_request_headers
    custom_response_headers                                                 = var.custom_response_headers
    dynamic "iap" {
        for_each                                                            = var.iap [*]
        content {
            oauth2_client_id                                                = lookup(iap.value, "oauth2_client_id","")
            oauth2_client_secret                                            = lookup(iap.value, "oauth2_client_secret", "")
            oauth2_client_secret_sha256                                     = lookup(iap.value, "oauth2_client_secret_sha256" , null)
        }
    }
    dynamic "locality_lb_policies" {
        for_each                                                            = var.locality_lb_policies
        content {
            dynamic "policy" {
                for_each                                                    = lookup(locality_lb_policies.value, "policy", "")
                content {
                    name                                                    = lookup(policy.value, "name", "")
                } 
            }
            dynamic "custom_policy" {
                for_each                                                    = lookup(locality_lb_policies.value, "custom_policy" , "")
                content {
                    name                                                    = lookup(custom_policy.value, "name", "")
                    data                                                    = lookup(custom_policy.value, "data", "")
                }
            }
        }
    }
    dynamic "outlier_detection" {
        for_each                                                            = var.outlier_detection
        content {
            dynamic "base_ejection_time" {
                for_each                                                    = lookup(outlier_detection.value, "base_ejection_time", "")
                content {
                    seconds                                                 = lookup(base_ejection_time.value, "second", null)
                    nanos                                                   = lookup(base_ejection_time.value, "nanos", "")
                }
            }
            consecutive_errors                                              = lookup(outlier_detection.value, "consecutive_errors", "")
            consecutive_gateway_failure                                     = lookup(outlier_detection.value, "consecutive_gateway_failure", "")
            enforcing_consecutive_errors                                    = lookup(outlier_detection.value, "enforcing_consecutive_errors", "")
            enforcing_consecutive_gateway_failure                           = lookup(outlier_detection.value, "enforcing_consecutive_gateway_failure", "")
            enforcing_success_rate                                          = lookup(outlier_detection.value, "enforcing_success_rate", "")
            dynamic "interval" {
                for_each                                                    = lookup(outlier_detection.value, "interval", "")
                content {
                    seconds                                                 = lookup(interval.value, "second" , null)
                    nanos                                                   = lookup(interval.value, "nanos", "")
                }
            }
            max_ejection_percent                                            = lookup(outlier_detection.value, "max_ejection_percent", "")
            success_rate_minimum_hosts                                      = lookup(outlier_detection.value, "success_rate_minimum_hosts", "")
            success_rate_request_volume                                     = lookup(outlier_detection.value, "success_rate_request_volume", "")
            success_rate_stdev_factor                                       = lookup(outlier_detection.value, "success_rate_stdev_factor", "")
        }
    }
    port_name                                                               = local.port_name

    dynamic "security_settings" {
        for_each                                                            = var.security_settings
        content {
            client_tls_policy                                               = lookup(security_settings.value, "client_tls_policy", "")
            subject_alt_names                                               = lookup(security_settings.value, "subject_alt_names", "")
        }
    }
    session_affinity                                                        = local.session_affinity
    dynamic "log_config" {
        for_each                                                            = var.log_config
        content {
            enable                                                          = lookup(log_config.value, "enable", "")
            sample_rate                                                     = lookup(log_config.value, "sample_rate", )
        }
    }
}


#.................................................... Backend Bucket ....................................................#

resource "google_compute_backend_bucket" "backend" {
    count                       = local.backend_type == "bucket" ? 1 : 0
    project                     = local.project
    name                        = var.backend_bucket_name
    description                 = var.backend_bucket_description
    bucket_name                 = var.bucket_name 
    enable_cdn                  = local.enable_cdn
    edge_security_policy        = local.edge_security_policy
}

#.................................................. Regional Frontend ...................................................#

resource "google_compute_forwarding_rule" "frontend" {
    count                                                   = local.scope == "regional" ? 1 : 0
    project                                                 = var.frontend_project_id != null ? local.project : var.frontend_project_id              
    name                                                    = local.frontend_name
    is_mirroring_collector                                  = var.is_mirroring_collector
    description                                             = local.frontend_description
    ip_address                                              = local.ip_address
    ip_protocol                                             = local.ip_protocol
    backend_service                                         = var.backend_service 
    load_balancing_scheme                                   = local.load_balancing_scheme
    network                                                 = local.network
    port_range                                              = local.port_range
    ports                                                   = var.ports
    subnetwork                                              = local.subnetwork 
    target                                                  = local.scope == "regional" && local.proxy_type == "https" ? google_compute_region_target_https_proxy.default[0].id : google_compute_region_target_http_proxy.default[0].id
    allow_global_access                                     = var.allow_global_access
    labels                                                  = local.labels
    all_ports                                               = var.all_ports
    network_tier                                            = var.network_tier
    dynamic "service_directory_registrations" {
        for_each                                            = local.service_directory_registrations
        content {
            namespace                                       = lookup(service_directory_registrations.value, "namespace")
            service                                         = lookup(service_directory_registrations.value, "service")
        } 
    }
    service_label                                           = var.service_label 
    source_ip_ranges                                        = local.source_ip_ranges
    allow_psc_global_access                                 = local.allow_psc_global_access
    no_automate_dns_zone                                    = local.no_automate_dns_zone
    ip_version                                              = local.ip_version
    region                                                  = local.region
    recreate_closed_psc                                     = var.recreate_closed_psc
}

#...................................................Global Frontend .....................................................#


resource "google_compute_global_forwarding_rule" "frontend" {
    count                                                   = local.scope == "global" ? 1 : 0
    project                                                 = var.frontend_project_id != null ? local.project : var.frontend_project_id
    description                                             = local.frontend_description                 
    name                                                    = local.frontend_name
    ip_protocol                                             = local.ip_protocol
    load_balancing_scheme                                   = local.load_balancing_scheme
    port_range                                              = local.port_range
    target                                                  = local.scope == "global" && local.proxy_type == "https" ? google_compute_target_https_proxy.default[0].id : google_compute_target_http_proxy.default[0].id
    ip_address                                              = local.ip_address
    ip_version                                              = local.ip_version
    labels                                                  = local.labels
    dynamic "metadata_filters" {
      for_each                                              = var.metadata_filters[*]
      content {
        filter_match_criteria                               = lookup(metadata_filters.value, "filter_match_criteria", "")
        dynamic "filter_labels" {
          for_each                                          = lookup(metadata_filters.value, "filter_labels", [])
          content {
            name                                            = lookup(filter_labels.value, "name")
            value                                           = lookup(filter_labels.value, "value")
          }
        }
      }
    }
    network                                                 = local.network
    subnetwork                                              = local.subnetwork
    source_ip_ranges                                        = local.source_ip_ranges
    allow_psc_global_access                                 = local.allow_psc_global_access
    no_automate_dns_zone                                    = local.no_automate_dns_zone
    dynamic "service_directory_registrations" {
        for_each                                            = local.service_directory_registrations
        content {
            namespace                                       = lookup(service_directory_registrations.value, "namespace")
            service_directory_region                        = lookup(service_directory_registrations.value, "service_directory_region")
        } 
    }  
}