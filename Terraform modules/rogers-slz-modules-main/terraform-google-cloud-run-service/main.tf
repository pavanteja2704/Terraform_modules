/* locals {
  cmek_template_annotation = var.encryption_key != null ? { "run.googleapis.com/encryption-key" = var.encryption_key } : {}
  template_annotations     = merge(var.template_annotations, local.cmek_template_annotation)
} */

resource "google_cloud_run_service" "service" {
  provider                                = google-beta
  name                                    = var.service_name
  location                                = var.location

  # User can generate multiple scenarios here
  # Providing 50-50 split with revision names
  # latest_revision is true only when revision_name is not provided, else its false
  dynamic "traffic" {
    for_each                              = var.traffic[*]
    content {
      revision_name                       = lookup(traffic.value, "latest_revision") ? null : lookup(traffic.value, "revision_name")
      percent                             = lookup(traffic.value, "percent", 100)
      tag                                 = lookup(traffic.value, "tag", null)
      latest_revision                     = lookup(traffic.value, "latest_revision", null)
      url                                 = lookup(traffic.value, "url", null)
    }
  }

  dynamic "template" {
    for_each                              = var.template[*]
    content {
      dynamic "metadata" {
        for_each                          = lookup(template.value, "metadata", [])
        content {
          labels                          = lookup(metadata.value, "labels", {})
          generation                      = lookup(metadata.value, "generation", null)
          resource_version                = lookup(metadata.value, "resource_version", null)
          self_link                       = lookup(metadata.value, "self_link", null)
          uid                             = lookup(metadata.value, "uid", null)
          namespace                       = var.project_id
          annotations                     = lookup(metadata.value, "annotations", {})
          name                            = lookup(metadata.value, "name", {})
        }
      }

      spec {
        containers {
          name                            = var.containers["name"]
          args                            = var.containers["args"]
          image                           = var.containers["image"]
          command                         = var.containers["command"]

          dynamic "env" {
            for_each                      = var.env[*]
            content {
              name                        = lookup(env.value, "name", "")
              value                       = lookup(env.value, "value", "")

              dynamic "value_from" {
                for_each                  = lookup(env.value, "value_from", [])
                content {
                  secret_key_ref {
                    key                   = lookup(value_from.value, "key", "")
                    name                  = lookup(value_from.value, "name", "")
                  }
                }
              }
            }
          }
          
          dynamic "ports" {
            for_each                      = var.ports[*]
            content {
              name                        = lookup(ports.value, "name", "")
              protocol                    = lookup(ports.value, "protocol", "")
              container_port              = lookup(ports.value, "container_port", "")
            }
          }

          dynamic "resources" {
            for_each                      = var.resources[*]
            content {
              limits                      = lookup(resources.value, "limits", "")
              requests                    = lookup(resources.value, "requests", "")
            }
          }

          dynamic "volume_mounts" {
            for_each                      = var.volume_mounts[*]
            content {
              mount_path                  = lookup(volume_mounts.value, "mount_path", "")
              name                        = lookup(volume_mounts.value, "name", "")
            }
          }

          dynamic "startup_probe" {
            for_each                        = var.startup_probe[*]
            content {
              initial_delay_seconds         = lookup(startup_probe.value, "initial_delay_seconds", "")
              timeout_seconds               = lookup(startup_probe.value, "timeout_seconds", "")
              period_seconds                = lookup(startup_probe.value, "period_seconds", "")
              failure_threshold             = lookup(startup_probe.value, "failure_threshold", "")
              
              dynamic "tcp_socket" {
                for_each                    = lookup(startup_probe.value, "tcp_socket", [])
                content {
                  port                      = lookup(tcp_socket.value, "port", "")
                }
              }

              dynamic "http_get" {
                for_each                    = lookup(startup_probe.value, "http_get", [])
                content {
                  path                      = lookup(http_get.value, "path", "")
                  port                      = lookup(http_get.value, "port", "")
                  dynamic "http_headers" {
                    for_each                = lookup(http_get.value, "http_headers", [])
                    content {
                      name                  = lookup(http_headers.value, "name", "")
                      value                 = lookup(http_headers.value, "value", "")
                    }
                  }
                }
              }
            
              dynamic "grpc" {
                for_each                    = lookup(startup_probe.value, "grpc", [])
                content {
                  port                      = lookup(grpc.value, "port", "")
                  service                   = lookup(grpc.value, "service", "")
                }
              }
            }
          }
          
          dynamic "liveness_probe" {
            for_each                        = var.liveness_probe[*]
            content {
              initial_delay_seconds         = lookup(liveness_probe.value, "initial_delay_seconds", "")
              timeout_seconds               = lookup(liveness_probe.value, "timeout_seconds", "")
              period_seconds                = lookup(liveness_probe.value, "period_seconds", "")
              failure_threshold             = lookup(liveness_probe.value, "failure_threshold", "")
              
              dynamic "http_get" {
                for_each                    = lookup(liveness_probe.value, "http_get", [])
                content {
                  path                      = lookup(http_get.value, "path", "")
                  port                      = lookup(http_get.value, "port", "")
                  
                  dynamic "http_headers" {
                    for_each                = lookup(http_get.value, "http_headers", [])
                    content {
                      name                  = lookup(http_headers.value, "name", "")
                      value                 = lookup(http_headers.value, "value", "")
                    }
                  }
                }
              }
            
              dynamic "grpc" {
                for_each                    = lookup(liveness_probe.value, "grpc", [])
                content {
                  port                      = lookup(grpc.value, "port", "")
                  service                   = lookup(grpc.value, "service", "")
                }
              }
            }
          }
        }

        container_concurrency               = var.container_concurrency # maximum allowed concurrent requests 0,1,2-N
        timeout_seconds                     = var.timeout_seconds       # max time instance is allowed to respond to a request
        service_account_name                = var.service_account_email

        dynamic "volumes" {
          for_each                          = var.volumes[*]
          content {
            name                            = lookup(volumes.value, "name", null)
            dynamic "secret" {
              for_each                      = lookup(volumes.value, "secret", [])
              content { 
                secret_name                 = lookup(secret.value, "secret_name", "")
                default_mode                = lookup(secret.value, "default_mode", "")

                dynamic "items" {
                  for_each                  = lookup(secret.value, "items", [])
                  content { 
                    key                     = lookup(items.value, "key", "")
                    path                    = lookup(items.value, "path", "")
                    mode                    = lookup(items.value, "mode", "")
                  }
                }
              }
            }
            
            dynamic "empty_dir" {
              for_each                      = lookup(volumes.value, "empty_dir", [])
              content { 
                medium                      = lookup(empty_dir.value, "medium", "")
                size_limit                  = lookup(empty_dir.value, "size_limit", "")
              }
            }

            dynamic "csi" {
              for_each                      = lookup(volumes.value, "csi", [])
              content { 
                driver                      = lookup(csi.value, "driver", "")
                read_only                   = lookup(csi.value, "read_only", "")
                volume_attributes           = lookup(csi.value, "volume_attributes", "")
              }
            }
          }
        }
      }
    }   
  } // template

  project                                   = var.project_id
  autogenerate_revision_name                = var.autogenerate_revision_name

  dynamic "metadata" {
    for_each                                = var.metadata[*]
    content {
      labels                                = lookup(metadata.value, "labels", {})
      generation                            = lookup(metadata.value, "generation", null)
      resource_version                      = lookup(metadata.value, "resource_version", null)
      self_link                             = lookup(metadata.value, "self_link", null)
      uid                                   = lookup(metadata.value, "uid", null)
      namespace                             = var.project_id
      annotations                           = lookup(metadata.value, "annotations", {})
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata[0].namespace,
      template[0].spec[0].containers[0].liveness_probe[0].http_get[0].path,
      template[0].spec[0].containers[0].liveness_probe[0].http_get[0].http_headers
      /* metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"],
      metadata[0].annotations["run.googleapis.com/operation-id"],
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"], */
    ]
  }
}