resource "google_compute_global_network_endpoint_group" "neg" {
    name                           = var.name
    network_endpoint_type          = var.network_endpoint_type
    description                    = var.description
    default_port                   = var.default_port
    project                        = var.project_id
}

resource "google_compute_global_network_endpoint" "endpoint" {
    count                          = var.create_endpoint ? 1 : 0
    port                           = var.port
    global_network_endpoint_group  = google_compute_global_network_endpoint_group.neg.name
    ip_address                     = var.ip_address
    fqdn                           = var.fqdn
    project                        = var.project_id
}