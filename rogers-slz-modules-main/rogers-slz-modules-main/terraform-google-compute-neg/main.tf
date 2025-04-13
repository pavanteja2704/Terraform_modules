resource "google_compute_network_endpoint_group" "default" {
    name                              = var.neg_name
    network                           = var.network_name
    description                       = var.description
    network_endpoint_type             = var.network_endpoint_type
    subnetwork                        = var.subnetwork
    default_port                      = var.default_port
    zone                              = var.zone
    project                           = var.project_id         
}

resource "google_compute_network_endpoint" "endpoint"{
    count                             = var.create_endpoints == true ? 0 : (var.create_endpoint ? 1 : 0)
    ip_address                        = var.ip_address
    network_endpoint_group            = google_compute_network_endpoint_group.default.name
    instance                          = var.instance
    port                              = var.port
    zone                              = var.zone
    project                           = var.project_id
}

resource "google_compute_network_endpoints" "endpoints" {
    count                            = var.create_endpoints ? 1 : 0
    network_endpoint_group           = google_compute_network_endpoint_group.default.name
    dynamic "network_endpoints" {
        for_each                     = var.network_endpoints[*]
        content {
          instance                   = lookup(network_endpoints.value, "instance")
          port                       = lookup(network_endpoints.value, "port")
          ip_address                 = lookup(network_endpoints.value, "ip_address") 
        }
    }
    zone                             = var.zone
    project                          = var.project_id 
}