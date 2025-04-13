#...................................................... locals ..........................................................#

locals {
    scope                                                                   = var.scope
    project                                                                 = var.project_id
    region                                                                  = var.region
    load_balancing_scheme                                                   = var.load_balancing_scheme
    
    frontend_name                                                           = var.frontend_name
    frontend_description                                                    = var.frontend_description
    ip_address                                                              = var.ip_address
    ip_protocol                                                             = var.ip_protocol
    network                                                                 = var.network
    subnetwork                                                              = var.subnetwork
    port_range                                                              = var.port_range
    labels                                                                  = var.labels
    source_ip_ranges                                                        = var.source_ip_ranges
    ip_version                                                              = var.ip_version
    allow_psc_global_access                                                 = var.allow_psc_global_access
    no_automate_dns_zone                                                    = var.no_automate_dns_zone
    service_directory_registrations                                         = var.service_directory_registrations
}

#.................................................. Regional Frontend ...................................................#

resource "google_compute_forwarding_rule" "frontend" {
    count                                                   = local.scope == "regional" ? 1 : 0
    project                                                 = var.frontend_project_id != null ? local.project : var.frontend_project_id              
    name                                                    = local.frontend_name
    is_mirroring_collector                                  = var.is_mirroring_collector
    description                                             = local.frontend_description
    ip_address                                              = local.ip_address
    ip_protocol                                             = local.ip_protocol
    backend_service                                         = var.backend_service 
    load_balancing_scheme                                   = local.load_balancing_scheme
    network                                                 = local.network
    port_range                                              = local.port_range
    ports                                                   = var.ports
    subnetwork                                              = local.subnetwork 
    target                                                  = var.target_proxy_id # local.scope == "regional" && local.proxy_type == "https" ? google_compute_region_target_https_proxy.default[0].id : google_compute_region_target_http_proxy.default[0].id
    allow_global_access                                     = var.allow_global_access
    labels                                                  = local.labels
    all_ports                                               = var.all_ports
    network_tier                                            = var.network_tier
    dynamic "service_directory_registrations" {
        for_each                                            = local.service_directory_registrations
        content {
            namespace                                       = lookup(service_directory_registrations.value, "namespace")
            service                                         = lookup(service_directory_registrations.value, "service")
        } 
    }
    service_label                                           = var.service_label 
    source_ip_ranges                                        = local.source_ip_ranges
    allow_psc_global_access                                 = local.allow_psc_global_access
    no_automate_dns_zone                                    = local.no_automate_dns_zone
    ip_version                                              = local.ip_version
    region                                                  = local.region
    recreate_closed_psc                                     = var.recreate_closed_psc
}

#...................................................Global Frontend .....................................................#


resource "google_compute_global_forwarding_rule" "frontend" {
    provider                                                = google-beta
    count                                                   = local.scope == "global" ? 1 : 0
    project                                                 = var.frontend_project_id != null ? local.project : var.frontend_project_id
    description                                             = local.frontend_description                 
    name                                                    = local.frontend_name
    ip_protocol                                             = local.ip_protocol
    load_balancing_scheme                                   = local.load_balancing_scheme
    port_range                                              = local.port_range
    target                                                  = var.target_proxy_id #local.scope == "global" && local.proxy_type == "https" ? google_compute_target_https_proxy.default[0].id : google_compute_target_http_proxy.default[0].id
    ip_address                                              = local.ip_address
    ip_version                                              = local.ip_version
    labels                                                  = local.labels
    dynamic "metadata_filters" {
      for_each                                              = var.metadata_filters[*]
      content {
        filter_match_criteria                               = lookup(metadata_filters.value, "filter_match_criteria", "")
        dynamic "filter_labels" {
          for_each                                          = lookup(metadata_filters.value, "filter_labels", [])
          content {
            name                                            = lookup(filter_labels.value, "name")
            value                                           = lookup(filter_labels.value, "value")
          }
        }
      }
    }
    network                                                 = local.network
    subnetwork                                              = local.subnetwork
    source_ip_ranges                                        = local.source_ip_ranges
    allow_psc_global_access                                 = local.allow_psc_global_access
    no_automate_dns_zone                                    = local.no_automate_dns_zone
    dynamic "service_directory_registrations" {
        for_each                                            = local.service_directory_registrations
        content {
            namespace                                       = lookup(service_directory_registrations.value, "namespace")
            service_directory_region                        = lookup(service_directory_registrations.value, "service_directory_region")
        } 
    }  
}