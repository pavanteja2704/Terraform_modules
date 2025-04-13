variable "bucket_name" {
  description = "Cloud storage bucket name"
  type        = string
}

variable "project_id" {
  description = "Bucket project id."
  type        = string
}

variable "gcs_location" {
  description = "Bucket location."
  type        = string
}

variable "storage_class" {
  description = "The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  type        = string
  validation {
    condition     = contains(["STANDARD","MULTI_REGIONAL","REGIONAL","NEARLINE","COLDLINE","ARCHIVE"], var.storage_class)
    error_message = "Storage Class must be any one of these ['STANDARD','MULTI_REGIONAL','REGIONAL','NEARLINE','COLDLINE','ARCHIVE']"
  }
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map(string)
}

variable "enable_versioning" {
  description = "The bucket's Versioning configuration."
  type        = bool
  validation {
    condition     = contains([true, false], var.enable_versioning)
    error_message = "Valid values for var: enable_versioning are (true, false)."
  }
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  type        = bool
  validation {
    condition     = contains([true, false], var.force_destroy)
    error_message = "Valid values for var: force_destroy are (true, false)."
  } 
}

variable "uniform_bucket_level_access" {
  description = "Enables Uniform bucket-level access access to a bucket."
  type        = bool
  validation {
    condition     = contains([true, false], var.uniform_bucket_level_access)
    error_message = "Valid values for var: uniform_bucket_level_access are (true, false)."
  }
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint. Defaults to inherited."
  type        = string
  validation {
    condition     = contains(["inherited", "enforced"], var.public_access_prevention)
    error_message = "Valid values for var: public_access_prevention are (inherited,enforced)."
  }
}

variable "custom_placement_config" {
  description = "Configuration of the bucket's custom location in a dual-region bucket setup. If the bucket is designated a single or multi-region, the variable are null."
  type = object({
    data_locations = list(string)
  })
}

variable "lifecycle_rule" {
  description = "The bucket's Lifecycle Rules configuration. Multiple blocks of this type are permitted."
  type = list(object(
    {
        action                                  = list(object(
            {
                type                            = string
                storage_class                   = string
            }
        )
        )
        condition                               = list(object(
            {
                age                             = number
                created_before                  = string
                with_state                      = string
                matches_storage_class           = list(string)
                matches_prefix                  = list(string)
                matches_suffix                  = list(string)
                num_newer_versions              = number
                custom_time_before              = string 
                days_since_custom_time          = string
                days_since_noncurrent_time      = string
                noncurrent_time_before          = string
            }
        )
        )
    }
    )
    )
}