output "id" {
    value = google_secret_manager_secret.secret.id
    description = "The fully-qualified id of the Secret Manager key that contains the secret."
}
