resource "google_monitoring_alert_policy" "policy" {
  display_name                       = var.display_name
  combiner                           = var.combiner

  conditions {
    dynamic "condition_absent" {
      for_each                       = var.condition_absent[*]
      content {
        dynamic "aggregations" {
          for_each                   = lookup(condition_absent.value, "aggregations", [])
          content {
            per_series_aligner       = lookup(aggregations.value, "per_series_aligner", null)
            group_by_fields          = lookup(aggregations.value, "group_by_fields", null)
            alignment_period         = lookup(aggregations.value, "alignment_period", null)
            cross_series_reducer     = lookup(aggregations.value, "cross_series_reducer", null)
          }
        }
        
        dynamic "trigger" {
          for_each                   = lookup(condition_absent.value, "trigger", [])
          content {
            percent                  = lookup(trigger.value, "percent", null)
            count                    = lookup(trigger.value, "count", null)
          }
        }

        duration                     = lookup(condition_absent.value, "duration", null)
        filter                       = lookup(condition_absent.value, "filter", null)
      }
    }

    name                             = var.name

    dynamic "condition_monitoring_query_language" {
      for_each                       = var.condition_monitoring_query_language[*]
      content {
        query                        = lookup(condition_monitoring_query_language.value, "query", "")
        duration                     = lookup(condition_monitoring_query_language.value, "duration", "")

        dynamic "trigger" {
          for_each                   = lookup(condition_monitoring_query_language.value, "trigger", [])
          content {
            percent                  = lookup(trigger.value, "percent", null)
            count                    = lookup(trigger.value, "count", null)
          }
        }
        evaluation_missing_data      = lookup(condition_monitoring_query_language.value, "evaluation_missing_data", null)
      }
    }

    dynamic "condition_threshold" {
      for_each                       = var.condition_threshold[*]
      content {
        threshold_value              = lookup(condition_threshold.value, "threshold_value", "")
        denominator_filter           = lookup(condition_threshold.value, "denominator_filter", "")

        dynamic "denominator_aggregations" {
          for_each                   = lookup(condition_threshold.value, "denominator_aggregations", [])
          content {
            per_series_aligner       = lookup(denominator_aggregations.value, "per_series_aligner", null)
            group_by_fields          = lookup(denominator_aggregations.value, "group_by_fields", null)
            alignment_period         = lookup(denominator_aggregations.value, "alignment_period", null)
            cross_series_reducer     = lookup(denominator_aggregations.value, "cross_series_reducer", null)
          }
        }

        duration                     = lookup(condition_threshold.value, "duration", "")

        dynamic "forecast_options" {
          for_each                   = lookup(condition_threshold.value, "forecast_options", [])
          content {
            forecast_horizon         = lookup(denominator_aggregations.value, "forecast_horizon", null)
          }
        }

        comparison                   = lookup(condition_threshold.value, "comparison", "")

        dynamic "trigger" {
          for_each                   = lookup(condition_threshold.value, "trigger", [])
          content {
            percent                  = lookup(trigger.value, "percent", null)
            count                    = lookup(trigger.value, "count", null)
          }
        }

        dynamic "aggregations" {
          for_each                   = lookup(condition_threshold.value, "aggregations", [])
          content {
            alignment_period         = lookup(aggregations.value, "alignment_period", null)
            per_series_aligner       = lookup(aggregations.value, "per_series_aligner", null)
            cross_series_reducer     = lookup(aggregations.value, "cross_series_reducer", null)
            group_by_fields          = lookup(aggregations.value, "group_by_fields", [])
          }
        }

      }
    }

      display_name                   = conditions.value["display_name"]
      condition_threshold {
        comparison         = lookup(conditions.value.condition_threshold, "comparison", "COMPARISON_GT")
        filter             = lookup(conditions.value.condition_threshold, "filter", null)
        threshold_value    = lookup(conditions.value.condition_threshold, "threshold_value", null)
        duration           = lookup(conditions.value.condition_threshold, "duration", "0s")
        denominator_filter = lookup(conditions.value.condition_threshold, "denominator_filter", "")

        dynamic "aggregations" {
          for_each = lookup(conditions.value.condition_threshold, "aggregations")
          content {
            alignment_period     = lookup(aggregations.value, "alignment_period", null)
            per_series_aligner   = lookup(aggregations.value, "per_series_aligner", null)
            cross_series_reducer = lookup(aggregations.value, "cross_series_reducer", null)
            group_by_fields      = lookup(aggregations.value, "group_by_fields", [])
          }
        }

        dynamic "denominator_aggregations" {
          for_each = lookup(conditions.value.condition_threshold, "denominator_aggregations", [])
          content {
            alignment_period     = lookup(denominator_aggregations.value, "alignment_period", null)
            per_series_aligner   = lookup(denominator_aggregations.value, "per_series_aligner", null)
            cross_series_reducer = lookup(denominator_aggregations.value, "cross_series_reducer", null)
            group_by_fields      = lookup(denominator_aggregations.value, "group_by_fields", [])
          }
        }

        trigger {
          count   = lookup(lookup(conditions.value.condition_threshold, "trigger", {}), "count", null)
          percent = lookup(lookup(conditions.value.condition_threshold, "trigger", {}), "percent", null)
        }
      }

      

      dynamic "condition_matched_log" {
        for_each = lookup(conditions.value, "condition_matched_log", [])
        content {
          filter           = lookup(condition_matched_log.value, "filter", "")
          label_extractors = lookup(condition_matched_log.value, "label_extractors", null)
        }
      }
    }

  project               = var.monitoring_project_id
  
  user_labels           = var.user_labels
  notification_channels = var.notification_channels
  enabled               = lookup(each.value, "enabled", "true")
  
  

  alert_strategy {
    auto_close = lookup(lookup(each.value, "alert_strategy", {}), "auto_close", null)
  }

  documentation {
    mime_type = lookup(lookup(each.value, "documentation", {}), "mime_type", "text/markdown")
    content   = lookup(lookup(each.value, "documentation", {}), "content", "Generated with terraform")
  }
}