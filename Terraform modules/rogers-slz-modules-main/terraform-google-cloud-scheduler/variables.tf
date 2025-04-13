variable "name" {
  description                = "(Required) The name of the job"
  type                       = string
}
variable "description" {
  description                = "(Optional) A human-readable description for the job."
  type                       = string
}
variable "schedule" {
  description                = "(Optional) A human-readable description for the job. This string must not contain more than 500 characters."
  type                       = string 
}
variable "time_zone" {
  description                = "(Optional) Specifies the time zone to be used in interpreting schedule. The value of this field must be a time zone name from the tz database."
  type                       = string
}
variable "paused" {
  description                = "(Optional) Sets the job to a paused state. Jobs default to being enabled when this property is not set."
  type                       = bool
}
variable "attempt_deadline" {
  description                = "(Optional) The deadline for job attempts. If the request handler does not respond by this deadline then the request is cancelled and the attempt is marked as a DEADLINE_EXCEEDED failure. "
  type                       = string
}
variable "retry_config" {
  description                = "(Optional) By default, if a job does not complete successfully, meaning that an acknowledgement is not received from the handler, then it will be retried with exponential backoff according to the settings"
  type                       = list(object({
    retry_count              = string
    max_retry_duration       = string
    min_backoff_duration     = string
    max_backoff_duration     = string
    max_doublings            = string
  }))
}
variable "pubsub_target" {
  description                = "(Optional) Pub/Sub target If the job providers a Pub/Sub target the cron will publish a message to the provided"
  type                       = list(object({
    topic_name               = string
    data                     = string
    attributes               = map(string)
  }))
} 
variable "app_engine_http_target" {
  description                = "(Optional) App Engine HTTP target. If the job providers a App Engine HTTP target the cron will send a request to the service instance Structure"
  type                       = list(object({
    http_method              = string
    app_engine_routing       = list(object({
      service                = string
      version                = string
      instance               = string
    }))
    relative_uri             = string
    body                     = string
    headers                  = string
  }))
}
variable "http_target" {
  description                = "(Optional) HTTP target. If the job providers a http_target the cron will send a request to the targeted url Structure"
  type                       = list(object({
    uri                      = string
    http_method              = string
    body                     = string
    headers                  = map(string)
    oauth_token              = list(object({
      service_account_email  = string
      scope                  = string
    }))
    oidc_token               = list(object({
      service_account_email  = string
      audience               = string
    }))
  }))
} 

variable "region" {
  description                = "(Optional) Region where the scheduler job resides. If it is not provided, Terraform will use the provider default."
  type                       = string
}
variable "project" {
  description                = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type                       = string
}