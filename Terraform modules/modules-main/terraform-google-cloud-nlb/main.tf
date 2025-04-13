#...................................................... locals .................................................#

locals {
    project                     = var.project_id
    region                      = var.region
    network                     = var.network
    subnetwork                  = var.subnetwork
    backend_type                = var.backend_type
    load_balancing_scheme       = var.load_balancing_scheme
}

#................................................. Target Pool .................................................#

resource "google_compute_target_pool" "pool" {
    count                       = local.backend_type == "target_pool" ? 1 : 0
    project                     = local.project
    region                      = local.region
    name                        = var.target_pool_name
    description                 = var.target_pool_description    
    instances                   = var.instances
    health_checks               = var.health_check_self_link
}


#.................................................... Backend ....................................................#

resource "google_compute_region_backend_service" "backend" {
    #provider                    = google-beta
    count                       = local.backend_type == "target_pool" ? 0 : 1
    project                     = local.project
    region                      = local.region
    network                     = local.network
    description                 = var.backend_description                 
    name                        = var.backend_name
    protocol                    = var.backend_protocol
    load_balancing_scheme       = local.load_balancing_scheme
    timeout_sec                 = var.backend_timeout_sec
    health_checks               = var.health_check_id

    dynamic "backend" {
        for_each                = var.backend
        content {
            group               = backend.value.group
        }
    }

    dynamic "log_config" {
        for_each                = var.log_config
        content {
            enable              = log_config.value.enable
            sample_rate         = log_config.value.sample_rate
        }
    }

    /* backend {
        group                   = var.mig_id
        balancing_mode          = var.backend_balancing_mode
    } */
}

#................................................... Frontend ....................................................#

resource "google_compute_forwarding_rule" "rule" {
    #provider                    = google-beta
    project                     = local.project
    description                 = var.frontend_description                 
    name                        = var.frontend_name
    region                      = local.region
    network                     = local.network
    subnetwork                  = local.subnetwork
    ip_protocol                 = var.ip_protocol
    load_balancing_scheme       = local.load_balancing_scheme
    all_ports                   = var.all_ports
    ip_address                  = var.ip_address
    port_range                  = local.backend_type == "target_pool" ? var.port_range : null
    ports                       = local.backend_type == "target_pool" ? null : var.ports
    target                      = local.backend_type == "target_pool" ? google_compute_target_pool.pool[0].id : null
    backend_service             = local.backend_type == "target_pool" ? null : google_compute_region_backend_service.backend[0].id
    allow_global_access         = var.allow_global_access
    labels                      = var.labels
}