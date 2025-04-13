#...................................................... locals ..........................................................#

locals {
    scope                                                                   = var.scope
    project                                                                 = var.project_id
    region                                                                  = var.region
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
}

#.................................................... Region Backend ....................................................#

resource "google_compute_region_backend_service" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "regional" ? 1 : 0
    name                                                                    = local.backend_service_name
    affinity_cookie_ttl_sec                                                 = local.affinity_cookie_ttl_sec
    region                                                                  = local.region
    project                                                                 = var.backend_project_id == null ? local.project : var.backend_project_id
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
            balancing_mode                                                  = lookup(backend.value, "balancing_mode" , null)
            capacity_scaler                                                 = lookup(backend.value, "capacity_scaler" , null)
            description                                                     = lookup(backend.value, "description" , null)
            failover                                                        = lookup(backend.value, "failover", null)
            group                                                           = lookup(backend.value, "group", null)
            max_connections                                                 = lookup(backend.value, "max_connections" , null)
            max_connections_per_instance                                    = lookup(backend.value, "max_connections_per_instance" , null)
            max_connections_per_endpoint                                    = lookup(backend.value, "max_connections_per_endpoint" , null)
            max_rate                                                        = lookup(backend.value, "max_rate", null)
            max_rate_per_instance                                           = lookup(backend.value , "max_rate_per_instance" , null)
            max_rate_per_endpoint                                           = lookup(backend.value, "max_rate_per_endpoint" , null)
            max_utilization                                                 = lookup(backend.value, "max_utilization", null)
        }
      
    }
    dynamic "circuit_breakers" {
        for_each                                                            = var.circuit_breakers
        content {
            dynamic "connect_timeout"   {
                for_each                                                    = lookup(circuit_breakers.value, "connect_timeout" , null)
                content {
                    seconds                                                 = lookup(connect_timeout.value, "seconds" , null)
                    nanos                                                   = lookup(connect_timeout.value, "nanos" , null)
                }
            }
            max_requests_per_connection                                     = lookup(circuit_breakers.value, "max_requests_per_connection", null)
            max_connections                                                 = lookup(circuit_breakers.value, "max_connections", null)
            max_pending_requests                                            = lookup(circuit_breakers.value, "max_pending_requests", null)
            max_requests                                                    = lookup(circuit_breakers.value, "max_requests", null)
            max_retries                                                     = lookup(circuit_breakers.value, "max_retries", null)
        }
      
    }
    dynamic "consistent_hash" {
        for_each                                                            = var.consistent_hash
        content {
            dynamic "http_cookie" {
           
            for_each                                                        = lookup(consistent_hash.value, "http_cookie", null)
            content {
                dynamic "ttl" {
                    for_each                                                = lookup(http_cookie.value, "ttl", null)
                    content {
                        seconds                                             = lookup(ttl.value, "seconds" , null)
                        nanos                                               = lookup(ttl.value, "nanos", null)
                    }
                }
            name                                                            = lookup(http_cookie.value, "name", null)
            path                                                            = lookup(http_cookie.value, "path", null)
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
                include_host                                                = lookup(cache_key_policy.value, "include_host", null)
                include_protocol                                            = lookup(cache_key_policy.value,"include_protocol", null)
                include_query_string                                        = lookup(cache_key_policy.value,"include_query_string", null)
                query_string_blacklist                                      = lookup(cache_key_policy.value,"query_string_blacklist", null)
                query_string_whitelist                                      = lookup(cache_key_policy.value,"query_string_whitelist", null)
                include_named_cookies                                       = lookup(cache_key_policy.value,"include_named_cookies", null)
                }
            }
        }
      
    }
    
    dynamic "failover_policy" {
        for_each                                                            = var.failover_policy
        content {
            disable_connection_drain_on_failover                            = lookup(failover_policy.value, "disable_connection_drain_on_failover", null)
            drop_traffic_if_unhealthy                                       = lookup(failover_policy.value, "drop_traffic_if_unhealthy", null)
            failover_ratio                                                  = lookup(failover_policy.value, "drop_traffic_if_unhealthy", null)
        }
    }
    
    dynamic "iap" {
        for_each                                                            = var.iap [*]
        content {
            oauth2_client_id                                                = lookup(iap.value, "oauth2_client_id", null)
            oauth2_client_secret                                            = lookup(iap.value, "oauth2_client_secret", null)
            oauth2_client_secret_sha256                                     = lookup(iap.value, "oauth2_client_secret_sha256", null)
        }
      
    }
    
    dynamic "outlier_detection" {
        for_each                                                            = var.outlier_detection [*]
        content {
            dynamic "base_ejection_time" {
                for_each                                                    = lookup(outlier_detection.value, "base_ejection_time", null)
                content {
                    seconds                                                 = lookup(base_ejection_time.value, "seconds",null)
                    nanos                                                   = lookup(base_ejection_time.value, "nanos" , null)
                }
            }
            consecutive_errors                                              = lookup(outlier_detection.value, "consecutive_errors", null)
            consecutive_gateway_failure                                     = lookup(outlier_detection.value,"consecutive_gateway_failure", null)
            enforcing_consecutive_errors                                    = lookup(outlier_detection.value,"enforcing_consecutive_errors", null)
            enforcing_consecutive_gateway_failure                           = lookup(outlier_detection.value,"enforcing_consecutive_gateway_failure", null)
            enforcing_success_rate                                          = lookup(outlier_detection.value,"enforcing_success_rate", null)
            dynamic "interval" {
                for_each                                                    = lookup(outlier_detection.value, "interval", null)
                content {
                    seconds                                                 = lookup(interval.value, "seconds",null)
                    nanos                                                   = lookup (interval.value, "nano" , null)
                }
            }
            max_ejection_percent                                            = lookup(outlier_detection.value, "max_ejection_percent", null)
            success_rate_minimum_hosts                                      = lookup(outlier_detection.value, "success_rate_minimum_hosts", null)
            success_rate_request_volume                                     = lookup(outlier_detection.value, "success_rate_request_volume" , null)
            success_rate_stdev_factor                                       = lookup(outlier_detection.value, "success_rate_stdev_factor", null)
        }  
    }
    
    dynamic "connection_tracking_policy" {
        for_each                                                            = var.connection_tracking_policy [*]
        content {
            idle_timeout_sec                                                = lookup(connection_tracking_policy.value, "idle_timeout_sec", null)
            tracking_mode                                                   = lookup(connection_tracking_policy.value, "tracking_mode", null)
            connection_persistence_on_unhealthy_backends                    = lookup(connection_tracking_policy.value, "connection_persistence_on_unhealthy_backends", null)
            enable_strong_affinity                                          = lookup(connection_tracking_policy, "enable_strong_affinity", null)
        }
    }
    
    dynamic "log_config" {
        for_each                                                            = var.log_config [*]
        content {
            enable                                                          = lookup(log_config.value, "enable", null)
            sample_rate                                                     = lookup(log_config.value,"sample", null)
        }
    }
    
    dynamic "subsetting" {
        for_each                                                            = var.subsetting
        content {
            policy                                                          = lookup(subsetting.value, "policy", null)
        }
    } 
}

#..................................................... Global Backend ....................................................#

resource "google_compute_backend_service" "default" {
    provider                                                                = google-beta
    count                                                                   = local.scope == "global" ? 1 : 0
    project                                                                 = var.backend_project_id == null ? local.project : var.backend_project_id
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
            balancing_mode                                                  = lookup(backend.value, "balancing_mode", null)
            capacity_scaler                                                 = lookup(backend.value, "capacity_scaler", null)
            description                                                     = lookup(backend.value, "description",null)
            group                                                           = lookup(backend.value, "group",null)
            max_connections                                                 = lookup(backend.value, "max_connections" , null)
            max_connections_per_instance                                    = lookup(backend.value, "max_connections_per_instance", null)
            max_connections_per_endpoint                                    = lookup(backend.value, "max_connections_per_endpoint",null)
            max_rate                                                        = lookup(backend.value, "max_rate",null)
            max_rate_per_instance                                           = lookup(backend.value, "max_rate_per_instance",null)
            max_rate_per_endpoint                                           = lookup(backend.value, "max_rate_per_endpoint", null)
            max_utilization                                                 = lookup(backend.value, "max_utilization",null)
        }
    }
    dynamic "circuit_breakers" {
        for_each                                                            = var.circuit_breakers [*]
        content {
            dynamic "connect_timeout"   {
                for_each                                                    = lookup(circuit_breakers.value, "connect_timeout" , null)
                content {
                    seconds                                                 = lookup(connect_timeout.value, "seconds" , null)
                    nanos                                                   = lookup(connect_timeout.value, "nanos" , null)
                }
            }      
            max_requests_per_connection                                     = lookup(circuit_breakers.value, "max_requests_per_connection" ,null)
            max_connections                                                 = lookup(circuit_breakers.value, "max_connections",null)
            max_pending_requests                                            = lookup(circuit_breakers.value, "max_pending_requests", null)
            max_requests                                                    = lookup(circuit_breakers.value, "max_requests", null)
            max_retries                                                     = lookup(circuit_breakers.value, "max_retries", null)
        }
    }
    compression_mode                                                        = var.compression_mode
    dynamic "consistent_hash" {
        for_each                                                            = var.consistent_hash [*]
        content {
            dynamic "http_cookie" {
                for_each                                                    = lookup(consistent_hash.value, "http_cookie", null)
                content {
                    dynamic "ttl" {
                        for_each                                            = lookup(http_cookie.value, "ttl", null)
                        content {
                        seconds                                             = lookup(ttl.value, "seconds", null)
                        nanos                                               = lookup(ttl.value, "nanos", null)
                        }
                    }
                }
            }
            http_header_name                                                = lookup(consistent_hash.value, "http_header_name", null)
            minimum_ring_size                                               = lookup(consistent_hash.value, "minimum_ring_size", null)
        }
    }
    dynamic "cdn_policy" {
        for_each                                                            = var.cdn_policy [*]
        content {
            dynamic "cache_key_policy" {
                for_each                                                    = lookup(cdn_policy.value, "cache_key_policy", null)
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
            oauth2_client_id                                                = lookup(iap.value, "oauth2_client_id",null)
            oauth2_client_secret                                            = lookup(iap.value, "oauth2_client_secret", null)
            oauth2_client_secret_sha256                                     = lookup(iap.value, "oauth2_client_secret_sha256" , null)
        }
    }
    dynamic "locality_lb_policies" {
        for_each                                                            = var.locality_lb_policies
        content {
            dynamic "policy" {
                for_each                                                    = lookup(locality_lb_policies.value, "policy", null)
                content {
                    name                                                    = lookup(policy.value, "name", null)
                } 
            }
            dynamic "custom_policy" {
                for_each                                                    = lookup(locality_lb_policies.value, "custom_policy" , null)
                content {
                    name                                                    = lookup(custom_policy.value, "name", null)
                    data                                                    = lookup(custom_policy.value, "data", null)
                }
            }
        }
    }
    dynamic "outlier_detection" {
        for_each                                                            = var.outlier_detection
        content {
            dynamic "base_ejection_time" {
                for_each                                                    = lookup(outlier_detection.value, "base_ejection_time", null)
                content {
                    seconds                                                 = lookup(base_ejection_time.value, "second", null)
                    nanos                                                   = lookup(base_ejection_time.value, "nanos", null)
                }
            }
            consecutive_errors                                              = lookup(outlier_detection.value, "consecutive_errors", null)
            consecutive_gateway_failure                                     = lookup(outlier_detection.value, "consecutive_gateway_failure", null)
            enforcing_consecutive_errors                                    = lookup(outlier_detection.value, "enforcing_consecutive_errors", null)
            enforcing_consecutive_gateway_failure                           = lookup(outlier_detection.value, "enforcing_consecutive_gateway_failure", null)
            enforcing_success_rate                                          = lookup(outlier_detection.value, "enforcing_success_rate", null)
            dynamic "interval" {
                for_each                                                    = lookup(outlier_detection.value, "interval", null)
                content {
                    seconds                                                 = lookup(interval.value, "second" , null)
                    nanos                                                   = lookup(interval.value, "nanos", null)
                }
            }
            max_ejection_percent                                            = lookup(outlier_detection.value, "max_ejection_percent", null)
            success_rate_minimum_hosts                                      = lookup(outlier_detection.value, "success_rate_minimum_hosts", null)
            success_rate_request_volume                                     = lookup(outlier_detection.value, "success_rate_request_volume", null)
            success_rate_stdev_factor                                       = lookup(outlier_detection.value, "success_rate_stdev_factor", null)
        }
    }
    port_name                                                               = local.port_name

    dynamic "security_settings" {
        for_each                                                            = var.security_settings
        content {
            client_tls_policy                                               = lookup(security_settings.value, "client_tls_policy", null)
            subject_alt_names                                               = lookup(security_settings.value, "subject_alt_names", null)
        }
    }
    session_affinity                                                        = local.session_affinity
    dynamic "log_config" {
        for_each                                                            = var.log_config
        content {
            enable                                                          = lookup(log_config.value, "enable", null)
            sample_rate                                                     = lookup(log_config.value, "sample_rate", )
        }
    }
}


#.................................................... Backend Bucket ....................................................#

resource "google_compute_backend_bucket" "backend" {
    count                                                                    = local.backend_type == "bucket" ? 1 : 0
    project                                                                  = local.project
    name                                                                     = var.backend_bucket_name
    description                                                              = var.backend_bucket_description
    bucket_name                                                              = var.bucket_name 
    enable_cdn                                                               = local.enable_cdn
    edge_security_policy                                                     = local.edge_security_policy
}