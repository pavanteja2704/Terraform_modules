resource "google_cloud_scheduler_job" "job" {
  name                                = var.name
  description                         = var.description
  schedule                            = var.schedule
  time_zone                           = var.time_zone
  paused                              = var.paused
  attempt_deadline                    = var.attempt_deadline

  dynamic "retry_config" {
    for_each                          = var.retry_config
    content {
      retry_count                     = lookup(retry_config.value, "retry_count", null)
      max_retry_duration              = lookup(retry_config.value, "max_retry_duration", null)
      min_backoff_duration            = lookup(retry_config.value, "min_backoff_duration", null)
      max_backoff_duration            = lookup(retry_config.value, "max_backoff_duration", null)
      max_doublings                   = lookup(retry_config.value, "max_doublings", null)
    }
  }
  dynamic "pubsub_target" {
    for_each                          = var.pubsub_target == null ? [] : var.pubsub_target[*]
    content {
      topic_name                      = lookup(pubsub_target.value, "topic_name", null)
      data                            = base64encode("${lookup(pubsub_target.value, "data", null)}")
      attributes                      = lookup(pubsub_target.value, "attributes", null)
    }
  }
   dynamic "app_engine_http_target" {
    for_each                          = var.pubsub_target == null ? [] : var.app_engine_http_target[*]
    content {
      http_method                     = lookup(app_engine_http_target.value,"http_method",null)
      dynamic "app_engine_routing" {
        for_each                      = lookup(app_engine_http_target.value,"app_engine_routing",null)
        content {
          service                     = lookup(app_engine_routing.value,"service",null) 
          version                     = lookup(app_engine_routing.value,"version",null)
          instance                    = lookup(app_engine_routing.value,"instance",null) 
        } 
      }
      relative_uri                    = lookup(app_engine_http_target.value,"relative_uri",null)
      body                            = lookup(app_engine_http_target.value,"body",null) 
      headers                         = lookup(app_engine_http_target.value,"headers",null) 
    }
  }
  dynamic "http_target" {
    for_each                          = (var.app_engine_http_target != null) && (var.pubsub_target != null) ? [] : var.http_target[*]
    content {
      uri                             = lookup(http_target.value,"uri",null)
      http_method                     = lookup(http_target.value,"http_method",null)
      body                            = base64encode("${lookup(http_target.value,"body",null)}")
      headers                         = lookup(http_target.value,"headers",null)
      dynamic "oauth_token" {
        for_each                      = lookup(http_target.value,"oauth_token",null)
        content {
          service_account_email       = lookup(oauth_token.value,"service_account_email",null)
          scope                       = lookup(oauth_token.value,"scope",null)
        } 
      }
      dynamic "oidc_token" {
        for_each                      = lookup(http_target.value,"oidc_token",[])
        content {
          service_account_email       = lookup(oidc_token.value,"service_account_email",null)
          audience                    = lookup(audience.value,"audience",null)
        }
      }
    } 
  } 
  region                              = var.region
  project                             = var.project
}