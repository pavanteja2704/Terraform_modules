#...................................................... locals ..........................................................#

locals {
    project                     = var.project_id
    proxy_type                  = var.target_proxy_type
    proxy_name                  = var.proxy_name
    proxy_description           = var.proxy_description
    url_map_id                  = var.url_map_id
}

#...................................................... HTTP Proxy ......................................................#

resource "google_compute_target_http_proxy" "default" {
    count                       = local.proxy_type == "http" ? 1 : 0
    project                     = local.project
    name                        = local.proxy_name
    description                 = local.proxy_description
    url_map                     = local.url_map_id
}

#..................................................... HTTPs Proxy ......................................................#

resource "google_compute_target_https_proxy" "default" {
    count                       = local.proxy_type == "https" ? 1 : 0
    project                     = local.project
    name                        = local.proxy_name
    description                 = local.proxy_description
    url_map                     = local.url_map_id
    ssl_certificates            = var.ssl_certificates_id
}