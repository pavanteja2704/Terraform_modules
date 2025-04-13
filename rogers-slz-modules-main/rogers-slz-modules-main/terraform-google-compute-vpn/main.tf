locals {
  project                         = var.project_id
  region                          = var.region
  network                         = var.network
  secret                          = random_id.secret.b64_url
  interconnect_attachment         = (var.create_interconnect_attachment ? google_compute_interconnect_attachment.on_prem[0].name : null)
  router                          = (var.create_router ? google_compute_router.router[0].name : var.router_name)
  vpn_gateway_self_link           = (var.create_vpn_gateway ? google_compute_vpn_gateway.gateway[0].self_link : var.vpn_gateway_self_link)
  ha_vpn_gateway_self_link        = (var.create_ha_vpn_gateway ? google_compute_ha_vpn_gateway.gateway[0].self_link : var.ha_vpn_gateway_self_link)
  peer_external_gateway           = (var.create_external_gateway ? google_compute_external_vpn_gateway.gateway[0].self_link : null)
}

resource "random_id" "secret" {
  byte_length                     = 8
}

resource "google_compute_vpn_gateway" "gateway" {
  count                           = var.create_vpn_gateway == true ? 1 : 0
  provider                        = google-beta
  name                            = var.vpn_gateway_name
  network                         = local.network
  description                     = var.vpn_gateway_description
  region                          = local.region
  project                         = local.project
}

resource "google_compute_ha_vpn_gateway" "gateway" {
  count                           = var.create_ha_vpn_gateway == true ? 1 : 0
  provider                        = google-beta
  name                            = var.ha_vpn_gateway_name
  network                         = local.network
  description                     = var.ha_vpn_gateway_description
  stack_type                      = var.stack_type

  dynamic "vpn_interfaces" {
    for_each                      = var.vpn_interfaces
    content {
      id                          = vpn_interfaces.value.id
      ip_address                  = vpn_interfaces.value.ip_address
      interconnect_attachment     = vpn_interfaces.value.interconnect_attachment
    }
  }
  region                          = local.region
  project                         = local.project
}

resource "google_compute_router" "router" {
  provider                        = google-beta
  count                           = var.create_router == true ? 1 : 0
  name                            = var.router_name
  network                         = local.network
  description                     = var.router_description
  
  dynamic "bgp" {
    for_each                      = var.bgp
    content {
      asn                         = bgp.value.asn
      advertise_mode              = bgp.value.advertise_mode
      advertised_groups           = bgp.value.advertised_groups

      dynamic "advertised_ip_ranges" {
        for_each                  = lookup(bgp.value, "advertised_ip_ranges", [])
        content {
          range                   = advertised_ip_ranges.value.range
          description             = advertised_ip_ranges.value.description
        }
      }
      keepalive_interval          = bgp.value.keepalive_interval
    }
  }

  encrypted_interconnect_router   = var.encrypted_interconnect_router
  region                          = local.region
  project                         = local.project
}

resource "google_compute_interconnect_attachment" "on_prem" {
  provider                        = google-beta
  count                           = var.create_interconnect_attachment == true ? 1 : 0
  router                          = local.router
  name                            = var.interconnect_attachment_name
  admin_enabled                   = var.admin_enabled
  interconnect                    = var.type == "DEDICATED" ? var.interconnect : null
  description                     = var.interconnect_attachment_description
  mtu                             = var.interconnect_attachment_mtu
  bandwidth                       = var.bandwidth
  edge_availability_domain        = var.edge_availability_domain
  type                            = var.interconnect_attachment_type
  candidate_subnets               = var.candidate_subnets
  vlan_tag8021q                   = var.vlan_tag8021q
  ipsec_internal_addresses        = var.ipsec_internal_addresses
  encryption                      = var.encryption
  stack_type                      = var.interconnect_attachment_stack_type
  region                          = local.region
  project                         = local.project
}

resource "google_compute_router_interface" "interface" {
  provider                        = google-beta
  name                            = var.router_interface_name
  router                          = local.router
  ip_range                        = var.ip_range
  vpn_tunnel                      = (var.create_interconnect_attachment == false && var.subnetwork == null) ? (
                                     google_compute_vpn_tunnel.tunnel.name) : null
  interconnect_attachment         = local.interconnect_attachment
  redundant_interface             = var.redundant_interface
  project                         = local.project
  subnetwork                      = var.subnetwork
  private_ip_address              = var.private_ip_address
  region                          = local.region
}

resource "google_compute_router_peer" "bgp_peer" {
  name                            = var.router_peer_name
  interface                       = google_compute_router_interface.interface.name
  peer_asn                        = var.router_peer_asn 
  router                          = local.router
  ip_address                      = var.router_ip_address
  peer_ip_address                 = var.router_ip_address != null ? var.router_peer_ip_address : null
  advertised_route_priority       = var.advertised_route_priority
  advertise_mode                  = var.advertise_mode
  advertised_groups               = var.advertise_mode != "CUSTOM" ? null : var.advertised_groups
  
  dynamic "advertised_ip_ranges" {
    for_each                      = (var.advertise_mode != "CUSTOM" ? {} : var.advertise_ip_ranges)
    content {
      range                       = lookup(advertised_ip_ranges.value, "range", null)
      description                 = lookup(advertised_ip_ranges.value, "description", null)
    }
  }

  dynamic "bfd" {
    for_each                      = var.bfd
    content {
      session_initialization_mode = lookup(bfd.value, "session_initialization_mode", null)
      min_transmit_interval       = lookup(bfd.value, "min_transmit_interval", null)
      min_receive_interval        = lookup(bfd.value, "min_receive_interval", null)
      multiplier                  = lookup(bfd.value, "multiplier", null)
    }
  }

  enable                          = var.enable
  router_appliance_instance       = var.router_appliance_instance
  enable_ipv6                     = var.enable_ipv6
  ipv6_nexthop_address            = var.ipv6_nexthop_address
  peer_ipv6_nexthop_address       = var.peer_ipv6_nexthop_address
  region                          = local.region
  project                         = local.project
}

resource "google_compute_external_vpn_gateway" "gateway" {
  provider                        = google-beta
  count                           = var.create_external_gateway == true ? 1 : 0
  name                            = var.external_vpn_gateway_name
  description                     = var.external_vpn_gateway_description
  labels                          = var.labels
  redundancy_type                 = var.redundancy_type

  dynamic "interface" {
    for_each                      = var.interface
    content {
      id                          = interface.value.id
      ip_address                  = interface.value.ip_address
    }
  }
  project                         = local.project
}

resource "google_compute_vpn_tunnel" "tunnel" {
  provider                        = google-beta
  name                            = var.vpn_tunnel_name
  shared_secret                   = var.shared_secret == "" ? local.secret : var.shared_secret
  description                     = var.vpn_tunnel_description
  target_vpn_gateway              = local.vpn_gateway_self_link
  vpn_gateway                     = local.ha_vpn_gateway_self_link
  vpn_gateway_interface           = var.vpn_gateway_interface
  peer_external_gateway           = local.peer_external_gateway
  peer_external_gateway_interface = var.peer_external_gateway_interface
  peer_gcp_gateway                = var.peer_gcp_gateway
  router                          = local.router
  peer_ip                         = var.peer_ip
  ike_version                     = var.ike_version
  local_traffic_selector          = var.local_traffic_selector
  remote_traffic_selector         = var.remote_traffic_selector
  labels                          = var.labels
  region                          = local.region
  project                         = local.project
}