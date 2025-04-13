#...................................................... locals .................................................#

locals {
    project                     = var.project_id
    region                      = var.region
    zone                        = var.zone
    labels                      = var.labels
    network                     = var.network
    subnetwork                  = var.subnetwork
}

#............................................... Instance Template ..............................................#

resource "google_compute_instance_template" "default" {
    #provider                    = google-beta
    name                        = var.instance_template_name
    project                     = local.project
    description                 = var.instance_template_description
    instance_description        = var.instance_description
    labels                      = local.labels
    
    tags                        = var.tags
    region                      = local.region
    machine_type                = var.machine_type

    // Create a new boot disk from an image
    disk {
        source_image            = var.source_image
        auto_delete             = var.auto_delete
        boot                    = var.boot
        disk_size_gb            = var.disk_size_gb
    }
    
    network_interface {
        subnetwork              = local.subnetwork                              
    }
    metadata                    = var.metadata
    lifecycle {
        create_before_destroy   = true
    }
}

#.................................................. Health Check ................................................#

resource "google_compute_region_health_check" "healthcheck" {
    project                     = local.project
    region                      = local.region
    name                        = var.health_check_name
    description                 = var.health_check_description
    check_interval_sec          = var.check_interval_sec
    timeout_sec                 = var.timeout_sec
    healthy_threshold           = var.healthy_threshold
    unhealthy_threshold         = var.unhealthy_threshold
    tcp_health_check {
        port                    = var.health_check_port
    }
}

#...................................................... MIG .....................................................#

resource "google_compute_instance_group_manager" "mig" {
    provider                    = google-beta
    project                     = local.project
    description                 = var.mig_description                 
    name                        = var.mig_name
    zone                        = local.zone
    base_instance_name          = var.base_instance_name

    named_port {
        name                    = var.named_port_name
        port                    = var.named_port_number
    }

    version {
        name                    = var.mig_version_name
        instance_template       = google_compute_instance_template.default.self_link_unique
    }

    all_instances_config {
        labels                  = local.labels
    }

    auto_healing_policies {
        health_check            = google_compute_region_health_check.healthcheck.id
        initial_delay_sec       = var.mig_initial_delay_sec
    }
}

#................................................... Autoscaler .................................................#

resource "google_compute_autoscaler" "autoscaler" {
    #provider                    = google-beta
    count                       = var.create_autoscaler ? 1 : 0
    project                     = local.project
    description                 = var.autoscaler_description                 
    name                        = var.autoscaler_name
    zone                        = local.zone
    target                      = google_compute_instance_group_manager.mig.id
    
    autoscaling_policy {
        min_replicas            = var.min_replicas
        max_replicas            = var.max_replicas
        cooldown_period         = var.cooldown_period
    }
}