output "NEG_Details" {
    value               = google_compute_region_network_endpoint_group.default
    description         = "Details of the Network Endpoint Group."
}
output "Endpoint_Details" {
  value                 = google_compute_region_network_endpoint.default
  description           = "Endpoint Details" 
}