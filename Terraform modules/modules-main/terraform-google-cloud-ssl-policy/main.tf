#........................................................................... locals ..............................................................................#
locals {
    scope              = var.scope
    project            = var.project_id
    region             = var.region
    name               = var.name
    description        = var.description
    profile            = var.profile
    min_tls_version    = var.min_tls_version
    custom_features    = var.custom_features
}

#........................................................................... Global SSL Policy ..............................................................................#

resource "google_compute_ssl_policy" "policy" {
    count              = local.scope == "global" ? 1 : 0
    project            = local.project
    name               = local.name
    description        = local.description
    profile            = local.profile
    min_tls_version    = local.min_tls_version
    custom_features    = local.custom_features
}

#........................................................................... Regional SSL Policy ..............................................................................#

resource "google_compute_region_ssl_policy" "policy" {
    count              = local.scope == "regional" ? 1 : 0
    project            = local.project
    region             = local.region
    name               = local.name
    description        = local.description
    profile            = local.profile
    min_tls_version    = local.min_tls_version
    custom_features    = local.custom_features
}