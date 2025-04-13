/* output "Cloud_Run_Service_Details" {
    value       = google_cloud_run_service.service
    description = "Cloud Run Service Output"
} */
output "Cloud_Run_Service_Name" {
    value       = google_cloud_run_service.service.name
    description = "Cloud Run Service Name"
}
output "Cloud_Run_Service_ID" {
    value       = google_cloud_run_service.service.id
    description = "Cloud Run Service ID"
}
output "Cloud_Run_Service_Image" {
    value       = google_cloud_run_service.service.template[0].spec[0].containers[0].image
    description = "Cloud Run Service Image"
}