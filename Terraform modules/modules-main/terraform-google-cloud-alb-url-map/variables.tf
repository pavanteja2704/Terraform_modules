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

#.................................................... URL Map ..................................................#

variable "url_map_name" {
  type                                  = string
  description                           = "(Required) Name of the resource."
}
variable "backend_service_id" {
  type                                  = string
  description                           = "(Optional) Backend Service ID"
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
  description                           = "(Optional) The list of HostRules to use against the URL."
  type                                  = list(object(
    {
      description                       = string
      hosts                             = list(string)
      path_matcher                      = string
    }
  ))
}
variable "path_matcher" {
  description                           = "(Optional) The list of named PathMatchers to use against the URL."
  type                                  = list(object({
    default_service                     = string
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
          backend_service               = string
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
          path_template_rewrite         = string
        }))
        weighted_backend_services       = list(object({
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
    
    path_rule                           = list(object({
      service                           = string
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
          backend_service               = string
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
          path_template_rewrite         = string
        }))
        weighted_backend_services       = list(object({
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
        path_template_rewrite           = string
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
      path_template_rewrite             = string
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