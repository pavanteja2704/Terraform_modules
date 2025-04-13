#...................................................... locals ..........................................................#

locals {
  project       = var.project_id
  region        = var.region
  address_type  = var.address_type
  purpose       = var.address_purpose
}

#...................................................... Address .........................................................#

resource "google_compute_address" "default" {
  project       = local.project
  region        = local.region
  name          = var.address_name
  description   = var.address_description
  address_type  = local.address_type 
  purpose       = local.purpose
  network_tier  = local.address_type == "INTERNAL" ? null : var.network_tier
  prefix_length = var.address_prefix_length  
  network       = local.address_type == "INTERNAL" && local.purpose == "VPC_PEERING" || local.purpose == "IPSEC_INTERCONNECT" ? var.address_network : null
  subnetwork    = local.address_type == "INTERNAL" && local.purpose == "GCE_ENDPOINT" ? var.address_subnetwork : null
  labels        = var.labels
  address       = local.address_type == "INTERNAL" ? var.address_ip : null
}