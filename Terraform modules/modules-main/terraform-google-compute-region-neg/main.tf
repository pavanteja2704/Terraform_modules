resource "google_compute_region_network_endpoint_group" "default" {
    provider                          = google-beta                     
    name                              = var.neg_name
    region                            = var.region
    description                       = var.description
    network_endpoint_type             = var.network_endpoint_type
    psc_target_service                = (var.network_endpoint_type == "PRIVATE_SERVICE_CONNECT") || (
                                         var.network_endpoint_type == "INTERNET_IP_PORT") || (
                                         var.network_endpoint_type == "INTERNET_FQDN_PORT") ? var.psc_target_service : null
    network                           = var.psc_target_service != null ? var.network : null
    subnetwork                        = var.network_endpoint_type == "PRIVATE_SERVICE_CONNECT" ? var.subnetwork : null

    dynamic "cloud_run" {
        for_each                      = var.cloud_run != [] ? var.cloud_run : []
        content {
            service                   = cloud_run.value.service
            tag                       = cloud_run.value.tag
            url_mask                  = cloud_run.value.url_mask
        }
    }

    dynamic "app_engine" {
        for_each                      = var.app_engine != [] ? var.app_engine : []
        content {
            service                   = app_engine.value.service
            version                   = app_engine.value.version
            url_mask                  = app_engine.value.url_mask
        }
    }

    dynamic "cloud_function" {
        for_each                      = var.cloud_function != [] ? var.cloud_function : []
        content {
            function                  = cloud_function.value.function
            url_mask                  = cloud_function.value.url_mask
        }
    }

    dynamic "serverless_deployment" {
        for_each                      = var.serverless_deployment != [] ? var.serverless_deployment : []
        content {
            platform                  = serverless_deployment.value.platform
            resource                  = serverless_deployment.value.resource
            version                   = serverless_deployment.value.version
            url_mask                  = serverless_deployment.value.url_mask
        }
    }
    project                           = var.project_id       
}

resource "google_compute_region_network_endpoint" "default" {
    count                             = var.create_endpoint ? 1 : 0
    port                              = var.create_endpoint ? var.port : null 
    region_network_endpoint_group     = google_compute_region_network_endpoint_group.default.name
    ip_address                        = var.create_endpoint ? var.ip_address : null
    fqdn                              = var.create_endpoint ? var.fqdn : null
    region                            = var.region
    project                           = var.project_id
}