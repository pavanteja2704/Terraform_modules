resource "google_compute_disk" "disk" {
    provider                      = google-beta
    name                          = var.disk_name
    project                       = var.project_id
    labels                        = var.labels
    size                          = var.size
    description                   = var.description 
    type                          = var.type
    zone                          = var.zone
    image                         = var.image
    physical_block_size_bytes     = var.physical_block_size_bytes
}