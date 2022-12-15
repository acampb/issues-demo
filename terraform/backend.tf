terraform {
  backend "gcs" {
    bucket = "terraform-state-c54db315"
    prefix = "terraform/state"
  }
}