resource "google_secret_manager_secret" "secret" {

  replication {
    dynamic "auto" {
      for_each                     = var.auto[*]
      content {
        dynamic "customer_managed_encryption" {
          for_each                 = var.auto[0].customer_managed_encryption == [] ? [] : lookup(auto.value, "customer_managed_encryption", [])
          content {
            kms_key_name           = lookup(customer_managed_encryption.value, "kms_key_name", {})
          }
        }
      }
    }
    /* dynamic "user_managed" {
      for_each                     = var.auto == null && var.user_managed == null ? [] : var.user_managed[*]
      content {
        dynamic "replicas" {
          for_each                 = lookup(user_managed.value, "replicas", [])
          content {
            location               = lookup(replicas.value, "location", {})
            
            dynamic "customer_managed_encryption" {
              for_each             = lookup(replicas.value, "customer_managed_encryption", [])
              content {
                kms_key_name       = lookup(customer_managed_encryption.value, "kms_key_name",{})
              }
            }
          }  
        }
      }      
    } */
  }

  secret_id                        = var.secret_id
  labels                           = var.labels
  annotations                      = var.annotations
  version_aliases                  = var.version_aliases

  dynamic "topics" {
    for_each                       = var.topics[*]
    content {
      name                         = lookup(topics.value, "name", {})
    }
  }

  expire_time                      = var.expire_time                 
  ttl                              = var.ttl

  dynamic "rotation" {
    for_each                       = var.rotation[*]
    content {
      next_rotation_time           = lookup(rotation.value, "next_rotation_time", {})
      rotation_period              = lookup(rotation.value, "rotation_period", {})
    }  
  }
  project                          = var.project_id    
}

resource "google_secret_manager_secret_version" "version" {
  secret                          = google_secret_manager_secret.secret.id
  secret_data                     = var.secret_data 
  enabled                         = var.enabled
  deletion_policy                 = var.deletion_policy
  is_secret_data_base64           = var.is_secret_data_base64
}
