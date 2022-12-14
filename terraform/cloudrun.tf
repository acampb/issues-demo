resource "google_project_service" "cloudrun" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "rm" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}
resource "google_cloud_run_service" "app" {
  depends_on = [
    google_project_service.cloudrun,
    google_project_service.rm
  ]
  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image
    ]
  }
  name     = "cloudrun-${terraform.workspace}"
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