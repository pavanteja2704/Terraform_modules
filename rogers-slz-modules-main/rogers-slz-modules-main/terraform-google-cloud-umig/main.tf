#...................................................... locals .................................................#

locals {
    project                     = var.project_id
    zone                        = var.zone
    network                     = var.network
}

#............................................... Instance Group ................................................#

resource "google_compute_instance_group" "umig" {
    name                        = var.umig_name
    zone                        = local.zone
    description                 = var.umig_description
    instances                   = var.umig_instances

    dynamic "named_port" {
        for_each                = var.named_port[*]
        content {
            name                = named_port.value.name
            port                = named_port.value.port
        }
    }

    project                     = local.project
    network                     = local.network
}