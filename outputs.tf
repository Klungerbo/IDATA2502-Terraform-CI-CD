output "frontend-ip" {
  value = google_compute_instance.frontend.network_interface.0.access_config.0.nat_ip
}

output "backend-ip" {
  value = google_compute_instance.backend.network_interface.0.access_config.0.nat_ip
}

output "db-ip" {
  value = google_compute_instance.db.network_interface.0.access_config.0.nat_ip
}