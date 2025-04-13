output "NEG_Details" {
    value               = google_compute_network_endpoint_group.default
    description         = "Details of the Network Endpoint Group."
}

output "Endpoint_Details" {
  value                 = google_compute_network_endpoint.endpoint
  description           = "Endpoint Details" 
}

output "Endpoints_Details" {
  value                 = google_compute_network_endpoints.endpoints
  description           = "Endpoints Details" 
}