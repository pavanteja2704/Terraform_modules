output "gateway" {
  description = "HA VPN gateway resource."
  value       = google_compute_ha_vpn_gateway.ha_gateway
}

output "router" {
  description = "Router resource (only if auto-created)."
  value       = var.router_name == "" ? google_compute_router.router[0] : null
}

output "router_name" {
  description = "Router name."
  value       = local.router
}

output "self_link" {
  description = "HA VPN gateway self link."
  value       = local.vpn_gateway_self_link
}

output "tunnels" {
  description = "VPN tunnel resources."
  sensitive   = true
  value = {
    for name in keys(var.tunnels) :
    name => google_compute_vpn_tunnel.tunnels[name]
  }
}

output "tunnel_names" {
  description = "VPN tunnel names."
  sensitive   = true
  value = {
    for name in keys(var.tunnels) :
    name => google_compute_vpn_tunnel.tunnels[name].name
  }
}

output "tunnel_self_links" {
  description = "VPN tunnel self links."
  sensitive   = true
  value = {
    for name in keys(var.tunnels) :
    name => google_compute_vpn_tunnel.tunnels[name].self_link
  }
}

output "random_secret" {
  description = "Generated secret."
  sensitive   = true
  value       = local.secret
}