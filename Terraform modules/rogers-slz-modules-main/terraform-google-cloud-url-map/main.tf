#...................................................... locals ..........................................................#

locals {
    project                     = var.project_id
}

#....................................................... URL Map ........................................................#

# Create url map
resource "google_compute_url_map" "default" {
    project                     = local.project
    name                        = var.url_map_name
    description                 = var.url_map_description
    default_service             = var.backend_bucket_id

    /* host_rule {
        hosts                   = ["*"]
        path_matcher            = "path-matcher"
    }
    path_matcher {
        name                    = "path-matcher"
        default_service         = google_compute_backend_bucket.bucket_1.id

    } */
}