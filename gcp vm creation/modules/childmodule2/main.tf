resource "google_storage_bucket" "ok_google" {
  name          = "pavan27041999"
  location      = "US"
   storage_class = "standard"
  force_destroy = true

  uniform_bucket_level_access = true
}
resource "google_storage_bucket_object" "raj" {
  name = "pavan_fail121"
  bucket = google_storage_bucket.ok_google.name
  source = "picup.jpg"
}
