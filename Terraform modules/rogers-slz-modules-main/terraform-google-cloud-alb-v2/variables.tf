#...................................................... locals .................................................#

variable "scope" {
  type                                  = string
  description                           = "Scope of the services: global or regional"
}
variable "project_id" {
  type                                  = string
  description                           = "The ID of the project in which the resource belongs."
}
variable "region" {
  type                                  = string
  description                           = "The region of the project in which the resource belongs."
}
variable "target_proxy_type" {
  type                                  = string
  description                           = "The target proxy type: HTTP or HTTPS"
}
variable "proxy_name" {
  type                                  = string
  description                           = "Name of the resource."
}
variable "proxy_description" {
  type                                  = string
  description                           = "An optional description of this resource."
}
variable "proxy_bind" {
  type                                  = string
  description                           = "(Optional) This field only applies when the forwarding rule that references this target proxy has a loadBalancingScheme set to INTERNAL_SELF_MANAGED."
}
variable "http_keep_alive_timeout_sec" {
  type                                  = number
  description                           = "(Optional) Specifies how long to keep a connection open, after completing a response, while there is no matching traffic (in seconds)"
}
variable "certificate_manager_certificates" {
  type                                  = list(string)
  description                           = "(Optional) URLs to certificate manager certificate resources that are used to authenticate connections between users and the load balancer."
}
variable "ssl_certificates_id" {
  type                                  = list(string)
  description                           = "(Optional) URLs to SslCertificate resources that are used to authenticate connections between users and the load balancer."
}
variable "ssl_policy" {
  type                                  = list(string)
  description                           = "(Optional) A reference to the SslPolicy resource that will be associated with the TargetHttpsProxy resource."
}
variable "load_balancing_scheme" {
  type                                  = string
  description                           = "Indicates what kind of load balancing will be used."
}

variable "backend_type" {
  type                                  = string
  description                           = "Indicates what kind of backend for load balancing will be used: MIG or Bucket"
}
variable "backend_service_name" {
  type                                  = string
  description                           = "Name of the resource."
}
variable "affinity_cookie_ttl_sec" {
  type                                  = string
  description                           = "(Optional) Lifetime of cookies in seconds if session_affinity is GENERATED_COOKIE. If set to 0, the cookie is non-persistent and lasts only until the end of the browser session (or equivalent). The maximum allowed value for TTL is one day. When the load balancing scheme is INTERNAL, this field is not used."  
}
variable "backend_service_description" {
  type                                  = string
  description                           = "An optional description of this resource."
}
variable "port_name" {
  type                                  = string
  description                           = "(Optional) Name of backend port. The same name should appear in the instance groups referenced by this service. Required when the load balancing scheme is EXTERNAL."
}
variable "backend_service_protocol" {
  type                                  = string
  description                           = "The protocol this BackendService uses to communicate with backends."
}
variable "connection_draining_timeout_sec" {
  type                                  = number
  description                           = "(Optional) Time for which instance will be drained (not accept new connections, but still work to finish started)."
}
variable "enable_cdn" {
  type                                  = bool
  description                           = "If true, enable Cloud CDN for this BackendBucket."
}
variable "health_check_id" {
  type                                  = list(string)
  description                           = "The set of URLs to the HttpHealthCheck or HttpsHealthCheck resource for health checking this BackendService."
}
variable "security_policy" {
  type                                  = string
  description                           = "The security policy associated with this backend service."
}
variable "edge_security_policy" {
  type                                  = string
  description                           = "(Optional) The resource URL for the edge security policy associated with this backend service."
}
variable "session_affinity" {
  type = string
  description = "Optional) Type of session affinity to use. The default is NONE. Session affinity is not applicable if the protocol is UDP. Possible values are: NONE, CLIENT_IP, CLIENT_IP_PORT_PROTO, CLIENT_IP_PROTO, GENERATED_COOKIE, HEADER_FIELD, HTTP_COOKIE."
}
variable "backend_service_timeout_sec" {
  type                                  = string
  description                           = "How many seconds to wait for the backend before considering it a failed request."
}


variable "frontend_description" {
  type                                  = string
  description                           = "An optional description of this resource."
}
variable "frontend_name" {
  type                                  = string
  description                           = "Name of the resource."
}
variable "ip_protocol" {
  type                                  = string
  description                           = "The IP protocol to which this rule applies. For protocol forwarding, valid options are TCP, UDP, ESP, AH, SCTP, ICMP and L3_DEFAULT"
}
variable "port_range" {
  type                                  = string
  description                           = "The port range of this resource"
}
variable "ip_address" {
  type                                  = string
  description                           = "IP address for which this forwarding rule accepts traffic."
}
variable "network" {
  type                                  = string
  description                           = "(Optional) This field is not used for external load balancing."
}
variable "subnetwork" {
  type                                  = string
  description                           = "(Optional) This field identifies the subnetwork that the load balanced IP should belong to for this Forwarding Rule"
}
variable "labels" {
  type                                  = map(string)
  description                           = "(Optional) Labels to apply to this forwarding rule. A list of key->value pairs."
}
variable "source_ip_ranges" {
  type                                  = list(string)
  description                           = "(Optional) If not empty, this Forwarding Rule will only forward the traffic when the source IP address matches one of the IP addresses or CIDR ranges set here."
}
variable "ip_version" {
  type                                  = list(string)
  description                           = "(Optional) The IP address version that will be used by this forwarding rule."
}
variable "allow_psc_global_access" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to control whether the PSC endpoint can be accessed from another region."
}
variable "no_automate_dns_zone" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to control whether it should try to auto-generate a DNS zone or not. Non-PSC forwarding rules do not use this field."
}
variable "service_directory_registrations" {
  description                           = "(Optional) Service Directory resources to register this forwarding rule with. "
  type                                  = list(object({
    namespace                           = string
    service                             = string
    service_directory_region            = string
  }))
}

#.................................................... URL Map ..................................................#

variable "url_map_name" {
  type                                  = string
  description                           = "(Required) Name of the resource."
}
variable "url_map_description" {
  type                                  = string
  description                           = "(Optional) An optional description of this resource."
}
variable "header_action" {
  description                           = "(Optional) Specifies changes to request and response headers that need to take effect for the selected backendService."
  type                                  = list(object({
    request_headers_to_add              = list(object({
      header_name                       = string
      header_value                      = string
      replace                           = bool
    }))
    request_headers_to_remove           = list(string)
    response_headers_to_add             = list(object({
      header_name                       = string
      header_value                      = string
      replace                           = bool
    }))
    response_headers_to_remove          = list(string)
  }))
}
variable "host_rule" {
  description                           = "(Optional) The list of HostRules to use against the URL. "
  type                                  = list(object({
    description                         = string
    hosts                               = list(string)
    path_matcher                        = string
  }))
}
variable "path_matcher" {
  description                           = "(Optional) The list of named PathMatchers to use against the URL."
  type                                  = list(object({
    #default_service                     = string
    description                         = string
    header_action                       = list(object({
      request_headers_to_add            = list(object({
        header_name                     = string
        header_value                    = string
        replace                         = bool
      }))

      request_headers_to_remove         = list(string)
      response_headers_to_add           = list(object({
        header_name                     = string
        header_value                    = string
        replace                         = bool
      }))
      response_headers_to_remove        = list(string)
    }))
    name                                = string
    path_rule                           = list(object({
      #service                           = string
      paths                             = list(string)
      route_action                      = list(object({
        cors_policy                     = list(object({
          allow_credentials             = bool
          allow_headers                 = list(string)
          allow_methods                 = list(string)
          allow_origin_regexes          = list(string)
          allow_origins                 = list(string)
          disabled                      = bool
          expose_headers                = list(string)
          max_age                       = number
        }))

        fault_injection_policy          = list(object({
          abort                         = list(object({
            http_status                 = number
            percentage                  = number
          }))
          delay                         = list(object({
            fixed_delay                 = list(object({
              nanos                     = number
              seconds                   = number
            }))
            percentage                  = number
          }))
        }))
        request_mirror_policy           = list(object({
          #backend_service               = string
        }))
        retry_policy                    = list(object({
          num_retries                   = number
          per_try_timeout               = list(object({
            nanos                       = number
            seconds                     = number
          }))
          retry_conditions              = list(string)
        }))
        timeout                         = list(object({
          nanos                         = number
          seconds                       = number
        }))
        url_rewrite                     = list(object({
          host_rewrite                  = string
          path_prefix_rewrite           = string
        }))
        weighted_backend_services       = list(object({
          backend_service               = string
          header_action                 = list(object({
            request_headers_to_add      = list(object({
              header_name               = string
              header_value              = string
              replace                   = bool
            }))
            request_headers_to_remove   = list(string)
            response_headers_to_add     = list(object({
              header_name               = string
              header_value              = string
              replace                   = bool
            }))
            response_headers_to_remove  = list(string)
          }))
          weight                        = number
        }))
      }))
      url_redirect                      = list(object({
        host_redirect                   = string
        https_redirect                  = bool
        path_redirect                   = string
        prefix_redirect                 = string
        redirect_response_code          = string
        strip_query                     = bool
      }))
    }))
    route_rules                         = list(object({
      priority                          = number
      service                           = string
      header_action                     = list(object({
        request_headers_to_add          = list(object({
          header_name                   = string
          header_value                  = string
          replace                       = bool
        }))
        request_headers_to_remove       = list(string)
        response_headers_to_add         = list(object({
          header_name                   = string
          header_value                  = string
          replace                       = bool
        }))
        response_headers_to_remove      = list(string)
      }))
      match_rules                       = list(object({
        full_path_match                 = string
        header_matches                  = list(object({
          exact_match                   = string
          header_name                   = string
          invert_match                  = bool
          prefix_match                  = string
          present_match                 = bool
          range_match                   = list(object({
            range_end                   = string
            range_start                 = string
          }))
          regex_match                   = string
          suffix_match                  = string
        }))
        ignore_case                     = bool
        metadata_filters                = list(object({
          filter_labels                 = list(object({
            name                        = string
            value                       = string
          }))
          filter_match_criteria         = string
        }))
        prefix_match                    = string
        query_parameter_matches         = list(object({
          exact_match                   = string
          name                          = string
          present_match                 = bool
          regex_match                   = string
        }))
        regex_match                     = string
        path_template_match             = string
      }))
      route_action                      = list(object({
        cors_policy                     = list(object({
          allow_credentials             = bool
          allow_headers                 = list(string)
          allow_methods                 = list(string)
          allow_origin_regexes          = list(string)
          allow_origins                 = list(string)
          disabled                      = bool
          expose_headers                = list(string)
          max_age                       = number
        }))

        fault_injection_policy          = list(object({
          abort                         = list(object({
            http_status                 = number
            percentage                  = number
          }))
          delay                         = list(object({
            fixed_delay                 = list(object({
              nanos                     = number
              seconds                   = number
            }))
            percentage                  = number
          }))
        }))
        request_mirror_policy           = list(object({
          #backend_service               = string
        }))
        retry_policy                    = list(object({
          num_retries                   = number
          per_try_timeout               = list(object({
            nanos                       = number
            seconds                     = number
          }))
          retry_conditions              = list(string)
        }))
        timeout                         = list(object({
          nanos                         = number
          seconds                       = number
        }))
        url_rewrite                     = list(object({
          host_rewrite                  = string
          path_prefix_rewrite           = string
        }))
        weighted_backend_services       = list(object({
          backend_service               = string
          header_action                 = list(object({
            request_headers_to_add      = list(object({
              header_name               = string
              header_value              = string
              replace                   = bool
            }))
            request_headers_to_remove   = list(string)
            response_headers_to_add     = list(object({
              header_name               = string
              header_value              = string
              replace                   = bool
            }))
            response_headers_to_remove  = list(string)
          }))
          weight                        = number
        }))
      }))
      url_redirect                      = list(object({
        host_redirect                   = string
        https_redirect                  = bool
        path_redirect                   = string
        prefix_redirect                 = string
        redirect_response_code          = string
        strip_query                     = bool
      }))
    }))
    default_url_redirect                = list(object({
      host_redirect                     = string
      https_redirect                    = bool
      path_redirect                     = string
      prefix_redirect                   = string
      redirect_response_code            = string
      strip_query                       = bool
    }))
    default_route_action                = list(object({
      weighted_backend_services         = list(object({
        backend_service                 = string
        header_action                   = list(object({
          request_headers_to_add        = list(object({
            header_name                 = string
            header_value                = string
            replace                     = bool
          }))
          request_headers_to_remove     = list(string)
          response_headers_to_add       = list(object({
            header_name                 = string
            header_value                = string
            replace                     = bool
          }))
          response_headers_to_remove    = list(string)
        }))
        weight                          = number
      }))

      url_rewrite                       = list(object({
        host_rewrite                    = string
        path_prefix_rewrite             = string
      }))

      timeout                           = list(object({
        nanos                           = number
        seconds                         = number
      }))

      retry_policy                      = list(object({
        num_retries                     = number
        per_try_timeout                 = list(object({
          nanos                         = number
          seconds                       = number
        }))
        retry_conditions                = list(string)
      }))

      request_mirror_policy             = list(object({
        backend_service                 = string
      }))

      cors_policy                       = list(object({
        allow_credentials               = bool
        allow_headers                   = list(string)
        allow_methods                   = list(string)
        allow_origin_regexes            = list(string)
        allow_origins                   = list(string)
        disabled                        = bool
        expose_headers                  = list(string)
        max_age                         = number
      }))

      fault_injection_policy            = list(object({
        abort                           = list(object({
          http_status                   = number
          percentage                    = number
        }))
        delay                           = list(object({
          fixed_delay                   = list(object({
            nanos                       = number
            seconds                     = number
          }))
          percentage                    = number
        }))
      }))
    }))
  }))
}
variable "test" {
  description                           = "(Optional) The list of expected URL mapping tests."
  type                                  = list(object({
    description                         = string
    host                                = string
    path                                = string
    service                             = string
  }))
}
variable "default_url_redirect" {
  description                           = "(Optional) When none of the specified hostRules match, the request is redirected to a URL specified by defaultUrlRedirect. "
  type                                  = list(object({
    host_redirect                       = string
    https_redirect                      = bool
    path_redirect                       = string
    prefix_redirect                     = string
    redirect_response_code              = string
    strip_query                         = bool
  }))
}
variable "default_route_action" {
  description                           = "(Optional) defaultRouteAction takes effect when none of the hostRules match."
  type                                  = list(object({
     weighted_backend_services          = list(object({
      backend_service                   = string
      header_action                     = list(object({
        request_headers_to_add          = list(object({
          header_name                   = string
          header_value                  = string
          replace                       = bool
        }))
        request_headers_to_remove       = list(string)
        response_headers_to_add         = list(object({
          header_name                   = string
          header_value                  = string
          replace                       = bool
        }))
        response_headers_to_remove      = list(string)
      }))
      weight                            = number
    }))

    url_rewrite                         = list(object({
      host_rewrite                      = string
      path_prefix_rewrite               = string
    }))

    timeout                             = list(object({
      nanos                             = number
      seconds                           = number
    }))

    retry_policy                        = list(object({
      num_retries                       = number
      per_try_timeout                   = list(object({
        nanos                           = number
        seconds                         = number
      }))
      retry_conditions                  = list(string)
    }))

    request_mirror_policy               = list(object({
      backend_service                   = string
    }))

    cors_policy                         = list(object({
      allow_credentials                 = bool
      allow_headers                     = list(string)
      allow_methods                     = list(string)
      allow_origin_regexes              = list(string)
      allow_origins                     = list(string)
      disabled                          = bool
      expose_headers                    = list(string)
      max_age                           = number
    }))

    fault_injection_policy              = list(object({
      abort                             = list(object({
        http_status                     = number
        percentage                      = number
      }))
      delay                             = list(object({
        fixed_delay                     = list(object({
          nanos                         = number
          seconds                       = number
        }))
        percentage                      = number
      }))
    }))
  }))
}
variable "url_map_project_id" {
  type                                  = string
  description                           = "The ID of the project in which the resource belongs."
}

#.................................................... Proxy ....................................................#

variable "proxy_project_id" {
  type                                  = string
  description                           = "(Optional) The ID of the project in which the resource belongs. "
}
variable "quic_override" {
  type                                  = string
  description                           = "(Optional) Specifies the QUIC override policy for this resource."
}
variable "certificate_map" {
  type                                  = string
  description                           = "(Optional) A reference to the CertificateMap resource uri that identifies a certificate map associated with the given target proxy."
}
variable "server_tls_policy" {
  type                                  = string
  description                           = "(Optional) A URL referring to a networksecurity.ServerTlsPolicy resource that describes how the proxy should authenticate inbound traffic."
}

#................................................. Backend MIG .................................................#


variable "backend_project_id" {
  type                                  = string
  description                           = "(Optional) The ID of the project in which the resource belongs. "
}
variable "backend" {
  type                                  = list(object({
    balancing_mode                      = string
    capacity_scaler                     = number
    description                         = string
    group                               = string
    max_connections                     = string
    max_connections_per_instance        = string
    max_connections_per_endpoint        = number
    max_rate                            = string
    max_rate_per_instance               = string
    max_rate_per_endpoint               = string
    max_utilization                     = string
  }))
  description = "(Optional) The set of backends that serve this BackendService."
  
}
variable "circuit_breakers" {
  type                                  = list(object({
    connect_timeout = list(object({
      seconds                           = number
      nanos                             = number
    }))
    max_requests_per_connection         = number
    max_connections                     = number
    max_pending_requests                = number
    max_requests                        = number
    max_retries                         = number
  }))
  description = " (Optional) Settings controlling the volume of connections to a backend service. This field is applicable only when the load_balancing_scheme is set to INTERNAL_SELF_MANAGED."
  
}
variable "compression_mode" {
  type                                  = string
  description                           = "(Optional) Compress text responses using Brotli or gzip compression, based on the client's Accept-Encoding header. Possible values are: AUTOMATIC, DISABLED."

}
variable "consistent_hash" {
  type                                  = list(object({
    http_cookie                         = list(object({
      ttl                               = list(object({
        seconds                         = number
        nanos                           = number
      }))
    }))
    http_header_name                    = string
    minimum_ring_size                   = number
  }))
  description                           = "(Optional) Consistent Hash-based load balancing can be used to provide soft session affinity based on HTTP headers, cookies or other properties. This load balancing policy is applicable only for HTTP connections. The affinity to a particular destination host will be lost when one or more hosts are added/removed from the destination service. This field specifies parameters that control consistent hashing. This field only applies if the load_balancing_scheme is set to INTERNAL_SELF_MANAGED. This field is only applicable when locality_lb_policy is set to MAGLEV or RING_HASH."
}
variable "cdn_policy" {
  type                                  = list(object({
    cache_key_policy                    = list(object({
      include_host                      = bool
      include_protocol                  = bool
      include_query_string              = bool
      query_string_blacklist            = list(string)
      query_string_whitelist            = list(string)
      include_http_headers              = list(string)
      include_named_cookies             = list(string)
    }))    
    }))
  description                           = "(Optional) Cloud CDN configuration for this BackendService."  
}
variable "failover_policy" {
  type                                  = list(object({
    disable_connection_drain_on_failover = string
    drop_traffic_if_unhealthy           = string
    failover_ratio                      = string
  }))
  description                           = "Optional) Policy for failovers."
}
variable "iap" {
  type                                  = list(object({
    oauth2_client_id                    = string
    oauth2_client_secret                = string
    oauth2_client_secret_sha256         = string 
  }))
  description                           = "(Optional) Settings for enabling Cloud Identity Aware Proxy"
}
variable "outlier_detection" {
  type                                  = list(object({
    base_ejection_time                  = list(object({
      seconds                           = number
      nanos                             = number
    }))
    consecutive_errors                  = number
    consecutive_gateway_failure         = number
    enforcing_consecutive_errors        = number
    enforcing_consecutive_gateway_failure = number
    enforcing_success_rate              = number
    interval                            = list(object({
      seconds                           = number
      nanos                             = number
    }))
    max_ejection_percent                = number
    success_rate_minimum_hosts          = number
    success_rate_request_volume         = number
    success_rate_stdev_factor           = number
  }))
  description                           = "(Optional) Settings controlling eviction of unhealthy hosts from the load balancing pool. Applicable backend service types can be a global backend service with the loadBalancingScheme set to INTERNAL_SELF_MANAGED or EXTERNAL_MANAGED. "
}
variable "connection_tracking_policy"{
  type                                  = list(object({
    idle_timeout_sec                    = string
    tracking_mode                       = string
    connection_persistence_on_unhealthy_backends = string
    enable_strong_affinity              = bool
  }))
  description                           = "(Optional, Beta) Connection Tracking configuration for this BackendService. This is available only for Layer 4 Internal Load Balancing and Network Load Balancing. "
}
variable "log_config" {
  type                                  = list(object({
    enable                              = bool
    sample_rate                         = number
  }))
  description                           = "(Optional) This field denotes the logging options for the load balancer traffic served by this backend service. If logging is enabled, logs will be exported to Stackdriver."
}
variable "subsetting" {
  type                                  = list(object({
    policy                              = string
  }))
  description                           = "(Optional, Beta) Subsetting configuration for this BackendService. Currently this is applicable only for Internal TCP/UDP load balancing and Internal HTTP(S) load balancing."  
}

variable "custom_request_headers" {
  type                                  = list(string)
  description                           = " (Optional) Headers that the HTTP/S load balancer should add to proxied requests."
  
}
variable "custom_response_headers" {
  type                                  = list(string)
  description                           = "(Optional) Headers that the HTTP/S load balancer should add to proxied responses."
  
}
variable "locality_lb_policies" {
  type                                  = list(object({
    policy                              = list(object({
      name                              = string
    }))
    custom_policy                       = list(object({
      name                              = string
      data                              = string
    }))
  }))
  description = "(Optional) The load balancing algorithm used within the scope of the locality. "
  
}
variable "security_settings" {
  type                                  = list(object({
    client_tls_policy                   = string
    subject_alt_names                   = list(string)
  }))
  description                           = "(Optional) The security settings that apply to this backend service. This field is applicable to either a regional backend service with the service_protocol set to HTTP, HTTPS, or HTTP2, and load_balancing_scheme set to INTERNAL_MANAGED; or a global backend service with the load_balancing_scheme set to INTERNAL_SELF_MANAGED."
}
variable "backend_service_network" {
  type                                  = string
  description                           = "(Optional) The URL of the network to which this backend service belongs. This field can only be specified when the load balancing scheme is set to INTERNAL."
  
}
variable "locality_lb_policy" {
  type                                  = string
  description                           = "(Optional) The load balancing algorithm used within the scope of the locality. "
}

#................................................ Backend Bucket ...............................................#

variable "backend_bucket_name" {
  type                                  = string
  description                           = "Name of the resource."
}
variable "backend_bucket_description" {
  type                                  = string
  description                           = "An optional description of this resource."
}
variable "bucket_name" {
  type                                  = string
  description                           = "Cloud Storage bucket name."
}

#.................................................... Frontend .................................................#

variable "frontend_project_id" {
  type                                  = string
  description                           = "(Optional) The ID of the project in which the resource belongs."
}
variable "is_mirroring_collector" {
  type                                  = string
  description                           = "(Optional) Indicates whether or not this load balancer can be used as a collector for packet mirroring."
}
variable "backend_service" {
  type                                  = string
  description                           = "(Optional) Identifies the backend service to which the forwarding rule sends traffic."
}
variable "ports" {
  type                                  = string
  description                           = "(Optional) The ports, portRange, and allPorts fields are mutually exclusive."
}
variable "allow_global_access" {
  type                                  = bool
  description                           = "(Optional) This field is used along with the backend_service field for internal load balancing or with the target field for internal TargetInstance."
}
variable "all_ports" {
  type                                  = string
  description                           = "(Optional) The ports, portRange, and allPorts fields are mutually exclusive."
}
variable "network_tier" {
  type                                  = string
  description                           = "(Optional) This signifies the networking tier used for configuring this load balancer and can only take the following values: PREMIUM, STANDARD"
}
variable "service_label" {
  type                                  = string
  description                           = "(Optional) An optional prefix to the service name for this Forwarding Rule."
}
variable "recreate_closed_psc" {
  type                                  = bool
  description                           = "(Optional) This is used in PSC consumer ForwardingRule to make terraform recreate the ForwardingRule when the status is closed"
}

variable "metadata_filters" {
  description                           = "(Optional) Opaque filter criteria used by Loadbalancer to restrict routing configuration to a limited set xDS compliant clients."
  type                                  = list(object({
    filter_match_criteria               = string
    filter_labels                       = list(object({
      name                              = string
      value                             = string
    }))
  }))
}