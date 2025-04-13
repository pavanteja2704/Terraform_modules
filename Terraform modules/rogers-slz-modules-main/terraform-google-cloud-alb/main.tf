#...................................................... locals ..........................................................#

locals {
    project                     = var.project_id
    proxy_type                  = var.target_proxy_type
    proxy_name                  = var.proxy_name
    proxy_description           = var.proxy_description
    load_balancing_scheme       = var.load_balancing_scheme
    backend_type                = var.backend_type
    enable_cdn                  = var.enable_cdn
    edge_security_policy        = var.edge_security_policy
    security_policy             = var.security_policy
}

#....................................................... URL Map ........................................................#

# Create url map
resource "google_compute_url_map" "default" {
    project                     = local.project
    name                        = var.url_map_name
    description                 = var.url_map_description
    default_service             = local.backend_type == "service" ? google_compute_backend_service.backend[0].id : google_compute_backend_bucket.backend[0].id

    /* host_rule {
        hosts                   = ["*"]
        path_matcher            = "path-matcher"
    }
    path_matcher {
        name                    = "path-matcher"
        default_service         = google_compute_backend_bucket.bucket_1.id

    } */
}

#...................................................... HTTP Proxy ......................................................#

resource "google_compute_target_http_proxy" "default" {
    count                       = local.proxy_type == "http" ? 1 : 0
    project                     = local.project
    name                        = local.proxy_name
    description                 = local.proxy_description
    url_map                     = google_compute_url_map.default.id
}

#..................................................... HTTPs Proxy ......................................................#

resource "google_compute_target_https_proxy" "default" {
    count                       = local.proxy_type == "https" ? 1 : 0
    project                     = local.project
    name                        = local.proxy_name
    description                 = local.proxy_description
    url_map                     = google_compute_url_map.default.id
    ssl_certificates            = var.ssl_certificates_id
}

#..................................................... Backend MIG ......................................................#

resource "google_compute_backend_service" "backend" {
    count                       = local.backend_type == "service" ? 1 : 0
    project                     = local.project
    name                        = var.backend_service_name
    description                 = var.backend_service_description    
    health_checks               = var.health_check_id
    load_balancing_scheme       = local.load_balancing_scheme
    protocol                    = var.backend_service_protocol
    timeout_sec                 = var.backend_service_timeout_sec
    security_policy             = local.security_policy
    edge_security_policy        = local.edge_security_policy
    enable_cdn                  = local.enable_cdn
    
    backend {
        group                   = var.group
        balancing_mode          = var.balancing_mode 
    }
}

#.................................................... Backend Bucket ....................................................#

resource "google_compute_backend_bucket" "backend" {
    count                       = local.backend_type == "bucket" ? 1 : 0
    project                     = local.project
    name                        = var.backend_bucket_name
    description                 = var.backend_bucket_description
    bucket_name                 = var.bucket_name 
    enable_cdn                  = local.enable_cdn
    edge_security_policy        = local.edge_security_policy
}

#...................................................... Frontend ........................................................#

resource "google_compute_global_forwarding_rule" "frontend" {
    project                     = local.project
    description                 = var.frontend_description                 
    name                        = var.frontend_name
    ip_protocol                 = var.ip_protocol
    load_balancing_scheme       = local.load_balancing_scheme
    port_range                  = var.port_range
    target                      = local.proxy_type == "https" ? google_compute_target_https_proxy.default[0].id : google_compute_target_http_proxy.default[0].id
    ip_address                  = var.ip_address
}