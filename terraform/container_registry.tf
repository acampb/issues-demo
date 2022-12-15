resource "google_project_service" "cr" {
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "cr" {
  depends_on = [
    google_project_service.cr
  ]
  location      = "us-east1"
  repository_id = "artifacts-dsdemo-c54db315"
  description   = "Repository for Docker images"
  format        = "DOCKER"
}
