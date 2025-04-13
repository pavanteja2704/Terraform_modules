#...................................................... locals ..........................................................#

locals {
    scope                                                                   = var.scope
    project                                                                 = var.project_id
    region                                                                  = var.region
    proxy_type                                                              = var.target_proxy_type
    proxy_name                                                              = var.proxy_name
    proxy_description                                                       = var.proxy_description
    proxy_bind                                                              = var.proxy_bind
    http_keep_alive_timeout_sec                                             = var.http_keep_alive_timeout_sec
    certificate_manager_certificates                                        = var.certificate_manager_certificates
    ssl_certificates                                                        = var.ssl_certificates_id
    ssl_policy                                                              = var.ssl_policy  
}


#................................................. Region HTTP Proxy ....................................................#

resource "google_compute_region_target_http_proxy" "default"{
    count                                                                   = local.scope == "regional" && local.proxy_type == "http" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = var.url_map_id
    description                                                             = local.proxy_description 
    region                                                                  = local.region
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#................................................ Region HTTPS Proxy ....................................................#

resource "google_compute_region_target_https_proxy" "default"{
    count                                                                   = local.scope == "regional" && local.proxy_type == "https" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = var.url_map_id
    description                                                             = local.proxy_description 
    certificate_manager_certificates                                        = local.certificate_manager_certificates
    ssl_certificates                                                        = local.ssl_certificates
    ssl_policy                                                              = local.ssl_policy
    region                                                                  = local.region
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#...................................................... HTTP Proxy ......................................................#

resource "google_compute_target_http_proxy" "default" {
    count                                                                   = local.scope == "global" && local.proxy_type == "http" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = var.url_map_id
    description                                                             = local.proxy_description
    proxy_bind                                                              = local.proxy_bind
    http_keep_alive_timeout_sec                                             = local.http_keep_alive_timeout_sec
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}

#..................................................... HTTPs Proxy ......................................................#

resource "google_compute_target_https_proxy" "default" {
    count                                                                   = local.scope == "global" && local.proxy_type == "https" ? 1 : 0
    name                                                                    = local.proxy_name
    url_map                                                                 = var.url_map_id
    description                                                             = local.proxy_description
    quic_override                                                           = var.quic_override
    certificate_manager_certificates                                        = local.certificate_manager_certificates
    ssl_certificates                                                        = local.ssl_certificates
    certificate_map                                                         = var.certificate_map
    ssl_policy                                                              = local.ssl_policy
    proxy_bind                                                              = local.proxy_bind
    http_keep_alive_timeout_sec                                             = local.http_keep_alive_timeout_sec
    server_tls_policy                                                       = var.server_tls_policy
    project                                                                 = var.proxy_project_id != null ? local.project : var.proxy_project_id
}