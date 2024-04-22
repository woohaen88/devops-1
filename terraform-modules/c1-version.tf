terraform {
  required_version = "~>1.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.25.0"
    }
  }
  backend "gcs" {
  }
}
