variable "topic_name" {
  description = "The name of the pub sub topic"
  type        = string
}
variable "project_id" {
  description = "The project under which pub sub topic to be created"
  type        = string
}
variable "labels" {
  description = "The labels to be set for the pubsub topic"
  type        = map(any)
}
variable "topic_message_retention_duration" {
  description = "The message retention duration to be set for the pubsub topic"
  type        = string
}
variable "subscription_name" {
  description = "The name of the pub sub subscription"
  type        = string
}
variable "sub_message_retention_duration" {
  description = "The message retention duration to be set for the pubsub subscription"
  type        = string
}
variable "retain_acked_messages" {
  description = "Retain acknowledged messages"
  type        = bool
}
variable "ack_deadline_seconds" {
  description = "Retain acknowledged messages time"
  type        = number
}
variable "expiration_policy" {
  description     = "(Optional) A policy that specifies the conditions for this subscription's expiration."
  type            = list(object({
    ttl           = string
  }))
}
variable "retry_policy" {
  description     = "(Optional) A policy that specifies how Pub/Sub retries message delivery for this subscription."
  type            = list(object({
    minimum_backoff = string
  }))
}
variable "enable_message_ordering" {
  description = "Message Ordering to be enabled/disabled for subscription"
  type        = bool
}