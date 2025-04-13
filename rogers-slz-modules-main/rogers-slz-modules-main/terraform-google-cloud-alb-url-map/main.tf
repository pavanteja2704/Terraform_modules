#...................................................... locals ..........................................................#

locals {
    scope                                                                   = var.scope
    project                                                                 = var.project_id
    region                                                                  = var.region
}

#.................................................... Global URL Map ....................................................#

# Create url map
resource "google_compute_url_map" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "global" ? 1 : 0
    name                                                                    = var.url_map_name
    default_service                                                         = var.backend_service_id
    description                                                             = var.url_map_description

    dynamic "header_action" {
        for_each                                                            = var.header_action
        content {
            dynamic "request_headers_to_add" {
                for_each                                                    = lookup(header_action.value, "request_headers_to_add", [])
                content {
                    header_name                                             = lookup(request_headers_to_add.value, "header_name", null)
                    header_value                                            = lookup(request_headers_to_add.value, "header_value", null)
                    replace                                                 = lookup(request_headers_to_add.value, "replace", null)
                }
            }
            request_headers_to_remove                                       = lookup(header_action.value, "request_headers_to_remove", null)

            dynamic "response_headers_to_add" {
                for_each                                                    = lookup(header_action.value, "response_headers_to_add", [])
                content {
                    header_name                                             = lookup(response_headers_to_add.value, "header_name", null)
                    header_value                                            = lookup(response_headers_to_add.value, "header_value", null)
                    replace                                                 = lookup(response_headers_to_add.value, "replace", null)
                }
            }
            response_headers_to_remove                                      = lookup(header_action.value, "response_headers_to_remove", null)
        }
    }

    dynamic "host_rule" {
        for_each                                                            = var.host_rule
        content {
            description                                                     = lookup(host_rule.value, "description", null)
            hosts                                                           = lookup(host_rule.value, "hosts", null)
            path_matcher                                                    = lookup(host_rule.value, "path_matcher", null)
        }
    }

    dynamic "path_matcher" {
        for_each                                                            = var.path_matcher[*]
        content {
            default_service                                                 = path_matcher.value.default_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
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
                                for_each                                    = lookup(route_action.value, "request_mirror_policy", [])
                                content {
                                    backend_service                         = request_mirror_policy.value.backend_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
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
                                    backend_service                         = weighted_backend_services.value.backend_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id

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
            host                                                            = test.value.host
            path                                                            = test.value.path
            service                                                         = test.value.service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
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
}


#................................................... Regional URL Map ...................................................#

# Create url map
resource "google_compute_region_url_map" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "regional" ? 1 : 0
    name                                                                    = var.url_map_name
    default_service                                                         = var.backend_service_id
    description                                                             = var.url_map_description

    dynamic "host_rule" {
        for_each                                                            = var.host_rule
        content {
            description                                                     = lookup(host_rule.value, "description", null)
            hosts                                                           = lookup(host_rule.value, "hosts", null)
            path_matcher                                                    = lookup(host_rule.value, "path_matcher", null)
        }
    }

    dynamic "path_matcher" {
        for_each                                                            = var.path_matcher[*]
        content {
            default_service                                                 = path_matcher.value.default_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
            description                                                     = path_matcher.value.description
            name                                                            = path_matcher.value.name

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
                                for_each                                    = lookup(match_rules.value, "metadata_filters", [])
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
                                    path_template_rewrite                   = url_rewrite.value.path_template_rewrite
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
                                for_each                                    = lookup(route_action.value, "request_mirror_policy", [])
                                content {
                                    backend_service                         = request_mirror_policy.value.backend_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
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
                                    #path_template_rewrite                   = url_rewrite.value.path_template_rewrite
                                }
                            }

                            dynamic "weighted_backend_services" {
                                for_each                                    = lookup(route_action.value, "weighted_backend_services", [])
                                content {
                                    backend_service                         = weighted_backend_services.value.backend_service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id

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
        }
    }

    dynamic "test" {
        for_each                                                            = var.test
        content {
            description                                                     = test.value.description
            host                                                            = test.value.host
            path                                                            = test.value.path
            service                                                         = test.value.service # local.backend_type == "service" ? (local.scope == "regional" ? google_compute_region_backend_service.default[0].id : google_compute_backend_service.default[0].id) : google_compute_backend_bucket.backend[0].id
        }
    }

    dynamic "default_url_redirect" {
        for_each                                                            = var.default_url_redirect
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
                    #path_template_rewrite                                   = url_rewrite.value.path_template_rewrite
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
    region                                                                  = local.region
    project                                                                 = var.url_map_project_id != null ? local.project : var.url_map_project_id
}