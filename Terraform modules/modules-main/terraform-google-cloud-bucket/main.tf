resource "google_storage_bucket" "bucket" {
  name                                = var.bucket_name
  project                             = var.project_id
  location                            = var.gcs_location
  force_destroy                       = var.force_destroy
  storage_class                       = var.storage_class
  labels                              = var.labels
  uniform_bucket_level_access         = var.uniform_bucket_level_access
  public_access_prevention            = var.public_access_prevention
  versioning {
    enabled                           = var.enable_versioning
  }
  dynamic "custom_placement_config" {
    for_each                          = var.custom_placement_config == null ? [] : [var.custom_placement_config]
    content {
      data_locations                  = custom_placement_config.value.data_locations
    }
  }

  dynamic "lifecycle_rule" {
    for_each                          = var.lifecycle_rule[*]
    content {
      dynamic "action" {
        for_each                      = lookup(lifecycle_rule.value, "action", [])
        content {
          type                        = lookup(action.value, "type", null)
          storage_class               = lookup(action.value, "type", null) == "SetStorageClass" ? lookup(action.value, "storage_class", null) : null
        }
      }

      dynamic "condition" {
        for_each                      = lookup(lifecycle_rule.value, "condition", [])
        content {
          age                         = lookup(condition.value, "age", null)
          created_before              = lookup(condition.value, "created_before", null)
          with_state                  = lookup(condition.value, "with_state", null)
          matches_storage_class       = lookup(condition.value, "matches_storage_class", null)
          matches_prefix              = lookup(condition.value, "matches_prefix", null) 
          matches_suffix              = lookup(condition.value, "matches_suffix", null)
          num_newer_versions          = lookup(condition.value, "num_newer_versions", null)
          custom_time_before          = lookup(condition.value, "custom_time_before", null) 
          days_since_custom_time      = lookup(condition.value, "days_since_custom_time", null) 
          days_since_noncurrent_time  = lookup(condition.value, "days_since_noncurrent_time", null)
          noncurrent_time_before      = lookup(condition.value, "noncurrent_time_before", null)
        }
      }
    }
  }
}
