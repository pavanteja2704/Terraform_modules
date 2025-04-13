#...................................................... locals .................................................#

locals {
    health_check_type           = var.health_check_type
    project                     = var.project_id
    region                      = var.region
    health_check_name           = var.health_check_name
    health_check_description    = var.health_check_description
    check_interval_sec          = var.check_interval_sec
    timeout_sec                 = var.timeout_sec
    healthy_threshold           = var.healthy_threshold
    unhealthy_threshold         = var.unhealthy_threshold
    health_check_port           = var.health_check_port
}

#.................................................. HTTP Health Check ................................................#

resource "google_compute_http_health_check" "healthcheck" {
    count                       = local.health_check_type == "http" ? 1 : 0    
    project                     = local.project
    name                        = local.health_check_name
    description                 = local.health_check_description
    check_interval_sec          = local.check_interval_sec
    timeout_sec                 = local.timeout_sec
    healthy_threshold           = local.healthy_threshold
    unhealthy_threshold         = local.unhealthy_threshold
    port                        = local.health_check_port
}

#..................................................Region Health Check ................................................#

resource "google_compute_region_health_check" "healthcheck" {
    #count                       = local.health_check_type == "region" ? 1 : 0    
    name                        = local.health_check_name
    check_interval_sec          = local.check_interval_sec
    description                 = local.health_check_description
    healthy_threshold           = local.healthy_threshold
    unhealthy_threshold         = local.unhealthy_threshold
    timeout_sec                 = local.timeout_sec

    dynamic "http_health_check" {
        for_each                = var.http_health_check[*]
        content {
            port                = lookup(http_health_check.value, "port", null)
        }
    }

    dynamic "tcp_health_check" {
        for_each                = var.tcp_health_check[*]
        content {
            port                = lookup(tcp_health_check.value, "port", null)
        }
    }

    project                     = local.project
    region                      = local.region
}