resource "google_project_service" "gar" {
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "gar" {
  depends_on = [
    google_project_service.gar
  ]
  location      = "us-east1"
  repository_id = "artifacts-dsdemo-${var.env_id}"
  description   = "Repository for Docker images"
  format        = "DOCKER"
}
