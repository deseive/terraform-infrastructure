# terragrunt.hcl for the Autopilot cluster project
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "/Users/roban/git/terraform-modules/project"
}

inputs = {
  name           = "gke"
  env_code       = "dev"
  environment    = "development"
  random_suffix  = "9dh3"
  alert_email    = "gc@roban.de"
  iam_impersonation   = "user:gc@roban.de"

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}