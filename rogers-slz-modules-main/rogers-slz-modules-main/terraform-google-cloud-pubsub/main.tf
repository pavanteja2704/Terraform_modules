/******************************************
  Google Cloud PubSub Topic and Subscription
 *****************************************/
resource "google_pubsub_topic" "pubsub_topic" {
  name                        = var.topic_name
  project                     = var.project_id
  labels                      = var.labels
  message_retention_duration  = var.topic_message_retention_duration
}

#.................................... Pubsub Subscription .................................#

resource "google_pubsub_subscription" "subscription" {
  name                        = var.subscription_name
  topic                       = google_pubsub_topic.pubsub_topic.id
  project                     = var.project_id
  labels                      = var.labels

  # 20 minutes
  message_retention_duration  = var.sub_message_retention_duration
  retain_acked_messages       = var.retain_acked_messages 

  ack_deadline_seconds        = var.ack_deadline_seconds

  dynamic "expiration_policy" {
    for_each                  = var.expiration_policy
    content {
      ttl                     = expiration_policy.value.ttl 
    }
  }
  dynamic "retry_policy" {
    for_each                  = var.retry_policy
    content {
      minimum_backoff         = retry_policy.value.minimum_backoff
    }
  }
  enable_message_ordering     = var.enable_message_ordering 
}