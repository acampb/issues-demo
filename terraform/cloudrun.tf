resource "google_project_service" "cloudrun" {
  service = "run.googleapis.com"
}

resource "google_project_service" "rm" {
  service = "cloudresourcemanager.googleapis.com"
}
resource "google_cloud_run_service" "app" {
  depends_on = [
    google_project_service.cloudrun
  ]
  name     = "cloudrun-dsdemo-${terraform.workspace}"
  location = "us-east1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "app" {
  location = google_cloud_run_service.app.location
  service  = google_cloud_run_service.app.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}