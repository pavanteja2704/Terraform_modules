variable "service_name" {
  description               = "The name of the Cloud Run service to create"
  type                      = string
  default                   = "cloud-run"
}
variable "location" {
  description               = "Cloud Run service deployment location"
  type                      = string
  default                   = "us-central1"
}
variable "traffic" {
  type                      = list(object({
    revision_name           = string
    percent                 = number
    tag                     = string
    latest_revision         = bool
    url                     = string
  }))
  description = "Managing traffic routing to the service"
  default = [
    {
      revision_name         = "v1-0-0"
      percent               = 100
      tag                   = null
      latest_revision       = true
      url                   = null
    }
  ]
}
variable "template" {
  description = "Managing traffic routing to the service"
  type = list(object(
    {
      metadata              = list(object(
        {
          labels            = object({})
          generation        = string
          resource_version  = string
          self_link         = string
          uid               = string
          annotations       = map(string)
          name              = string
        }))
    }))
    
    default = [
      {
      metadata              = [
        {
          labels            = {}
          generation        = null
          resource_version  = null
          self_link         = null
          uid               = null
          annotations       = {
            "run.googleapis.com/client-name" = "terraform"
          }
          name              = ""
        }]
      }
    ]
}
variable "containers" {
  type                             = object({
    name                           = string
    args                           = list(string)
    image                          = string
    command                        = list(string)
  })
  description = "Containers defines the unit of execution for this Revision."
  default                          = {
      name                           = "hello-container"
      args                           = []
      image                          = "us-docker.pkg.dev/cloudrun/container/hello"
      command                        = []
    }
}
variable "env" {
  description = "List of environment variables to set in the container."
  type                             = list(object(
    {
      name                         = string
      value                        = string
      value_from                   = list(object(
        {
          key                      = string
          name                     = string
        }))
    }))
    
    default = [
      {
        name                       = "PORT"
        value                      = "8080"
        value_from                 = [
          {
            key                    = ""
            name                   = ""
          }
        ]
      }
    ]
}
variable "ports" {
  type                             = list(object(
    {
      name                         = string
      protocol                     = number
      container_port               = number
    }))
  description = "Port which the container listens to (http1 or h2c)"
  default = [
    {
      name                         = ""
      protocol                     = null
      container_port               = "8080"
    }
  ]
}
variable "resources" {
  type                             = list(object(
    {
      limits                       = map(string)
      requests                     = map(string)
    }))
  description = "Compute Resources required by this container. Used to set values such as max memory"
  default = [
    {
      limits                       = null
      requests                     = null
    }
  ]
}
variable "volume_mounts" {
  type                             = list(object({
    mount_path                     = string
    name                           = string
  }))
  description                      = "[Beta] Volume Mounts to be attached to the container (when using secret)"
  default                          = [
    {
      mount_path                   = "/mnt/shared"
      name                         = "volume"
    }
  ]
}
variable "startup_probe" {
  description = "Startup probe of application within the container. All other probes are disabled if a startup probe is provided, until it succeeds."
  type                             = list(object(
    {
      initial_delay_seconds        = number
      timeout_seconds              = number
      period_seconds               = number
      failure_threshold            = number
      tcp_socket                   = list(object(
        {
          port                     = number
        }))
      http_get                     = list(object(
        {
          path                     = string
          port                     = number
          http_headers             = list(object(
            {
              name                 = string
              value                = string
            }))
        }))
      grpc                         = list(object(
        {
          port                     = string
          service                  = string
        }
      ))
    }))
    
    default = [
      {
        initial_delay_seconds        = null
        timeout_seconds              = null
        period_seconds               = null
        failure_threshold            = null
        tcp_socket                   = [
          /* {
            port                     = null
          } */
        ]
        http_get                     = [
          {
            path                     = ""
            port                     = null
            http_headers             = [
              {
                name                 = ""
                value                = ""
              }
            ]
          }
        ]
        grpc                         = [
          /* {
            port                     = null
            service                  = ""
          } */
        ]
      }
    ]
}

variable "liveness_probe" {
  description = "Periodic probe of container liveness. Container will be restarted if the probe fails."
  type                             = list(object(
    {
      initial_delay_seconds        = number
      timeout_seconds              = number
      period_seconds               = number
      failure_threshold            = number
      http_get                     = list(object(
        {
          path                     = string
          port                     = number
          http_headers             = list(object(
            {
              name                 = string
              value                = string
            }))
        }))
      grpc                         = list(object(
        {
          port                     = number
          service                  = string
        }
      ))
    }))
    
    default = [
      {
        initial_delay_seconds        = null
        timeout_seconds              = null
        period_seconds               = null
        failure_threshold            = null

        http_get                     = [
          {
            path                     = ""
            port                     = null
            http_headers             = [
              {
                name                 = ""
                value                = ""
              }
            ]
          }
        ]
        grpc                         = [
          /* {
            port                     = null
            service                  = ""
          } */
        ]
      }
    ]
}
variable "container_concurrency" {
  type                               = number
  description                        = "Concurrent request limits to the service"
  default                            = null
}
variable "timeout_seconds" {
  type                               = number
  description                        = "Timeout for each request"
  default                            = 120
}
variable "service_account_email" {
  type                               = string
  description                        = "Service Account email needed for the service"
  default                            = ""
}
variable "volumes" {
  description = "Volume represents a named volume in a container."
  type                             = list(object(
    {
      name                         = string
      secret                       = list(object(
        {
          secret_name              = string
          default_mode             = number
          items                    = list(object(
            {
              key                  = string
              path                 = string
              mode                 = number
            }))
        }))

      empty_dir                    = list(object(
        {
          medium                   = string
          size_limit               = string
        }))
      csi                          = list(object(
        {
          driver                   = string
          read_only                = bool
          volume_attributes        = map(string)
        }
      ))
    }))
    
    default = [
      {
        name                       = "volume"
        secret                     = [
          {
            secret_name            = "secret"
            default_mode           = null
            items                  = [
              {
                key                = "key"
                path               = ""
                mode               = null
              }
            ]
          }
        ]
        
        empty_dir                  = [
          {
            medium                 = "Memory"
            size_limit             = "128Mi"
          }
        ]
        csi                        = [
          /* {
            driver                 = ""
            read_only              = true
            volume_attributes      = {}
          } */
        ]
      }
    ]
  }
variable "project_id" {
  description                      = "The project ID to deploy to"
  type                             = string
  default                          = "peak-comfort-413811"
}
variable "autogenerate_revision_name" {
  type        = bool
  description = "Option to enable revision name generation"
  default     = true
}
variable "metadata" {
  description = "Metadata associated with this Service, including name, namespace, labels, and annotations."
  type = list(object(
    {
      labels            = object({})
      generation        = string
      resource_version  = string
      self_link         = string
      uid               = string
      annotations       = map(string)
    }))
    
    default = [
      {
        labels            = {}
        generation        = null
        resource_version  = null
        self_link         = null
        uid               = null
        annotations       = {
          "run.googleapis.com/launch-stage" = "BETA"
        }
      }
    ]
}