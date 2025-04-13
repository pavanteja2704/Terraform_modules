#...................................................... locals ..........................................................#

locals {
    scope                       = var.scope
    project                     = var.project_id
    certificate_type            = var.certificate_type
    ssl_certificate_name        = var.ssl_certificate_name
    ssl_certificate_description = var.ssl_certificate_description
}

#.................................................... SSL Certificate ...................................................#

data "google_secret_manager_secret_version" "private_key_secret" {
    count                       = local.certificate_type == "custom" ? 1 : 0  
    project                     = local.project
    secret                      = var.private_key_path
}

data "google_secret_manager_secret_version" "certificate_secret" {
    count                       = local.certificate_type == "custom" ? 1 : 0 
    project                     = local.project
    secret                      = var.certificate_path
}
resource "google_compute_region_ssl_certificate" "default" {
    count                       = local.scope == "regional" && local.certificate_type == "custom" ? 1 : 0  
    project                     = local.project
    region                      = var.region
    name                        = local.ssl_certificate_name
    description                 = local.ssl_certificate_description
    private_key                 = data.google_secret_manager_secret_version.private_key_secret.0.secret_data # file("${var.private_key_path}")
    certificate                 = data.google_secret_manager_secret_version.certificate_secret.0.secret_data # file("${var.certificate_path}")
}

resource "google_compute_ssl_certificate" "default" {
    count                       = local.scope == "global" && local.certificate_type == "custom" ? 1 : 0  
    project                     = local.project
    name                        = local.ssl_certificate_name
    description                 = local.ssl_certificate_description
    private_key                 = data.google_secret_manager_secret_version.private_key_secret.0.secret_data # file("${var.private_key_path}")
    certificate                 = data.google_secret_manager_secret_version.certificate_secret.0.secret_data # file("${var.certificate_path}")
}

resource "google_compute_managed_ssl_certificate" "default" {
    count                       = local.scope == "global" && local.certificate_type == "managed" ? 1 : 0        
    project                     = local.project
    name                        = local.ssl_certificate_name
    description                 = local.ssl_certificate_description

    dynamic "managed" {
        for_each                = var.managed
        content {
            domains             = managed.value.domains
        }
    }
}