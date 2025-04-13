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
    failover                            = bool
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
    disable_connection_drain_on_failover = bool
    drop_traffic_if_unhealthy           = bool
    failover_ratio                      = list(string)
  }))
  description                           = "(Optional) Policy for failovers."
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
    idle_timeout_sec                    = number
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
