variable "billing_account_id" {
  description = "The billing account id setting the budget"
  type        = string
}

variable "budget_name" {
  description = "The name of the budget quota to be allowed"
  type        = string
}

variable "project_id" {
  description = "The name of the project id on which quota to be set"
  type        = list(string)
}

variable "credit_types_treatment" {
  description = "Specifies how credits should be treated when determining spend for threshold calculations."
  type        = string
}

/* variable "labels" {
  description = "A single label and value pair specifying that usage from only this set of labeled resources should be included in the budget."
  type        = map(string)
} */

variable "currency_code" {
  description = "The 3-letter currency code defined in ISO 4217."
  type        = string
}

variable "budget_amount" {
  description = "The amount of the budget on which quota to be set"
  type        = number
}

variable "threshold_values" {
  description = "Send an alert when this threshold is exceeded. This is a 1.0-based percentage, so 0.5 = 50%. Must be >= 0."
  type        = list(string)
}

variable "budget_notify_name" {
  description = "The name of the budget notification for email"
  type        = string
}

variable "email_address" {
  description = "The email address to whom budget notification to be sent"
  type        = string
}