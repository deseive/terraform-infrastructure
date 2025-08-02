include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "/Users/roban/git/terraform-modules/gke-autopilot"
}

inputs = {
  name            = "gke"
  env_code        = "dev"
  environment     = "development"
  random_suffix   = "9dh3"

  release_channel = "REGULAR"

  network         = "projects/gke-dev-9dh3/global/networks/gke-autopilot-vpc"
  subnetwork      = "projects/gke-dev-9dh3/regions/europe-west1/subnetworks/gke-autopilot-subnet"

  cluster_secondary_range_name  = "pods-range"
  services_secondary_range_name = "services-range"

  enable_logging    = true
  enable_monitoring = true

  resource_labels = {
    owner = "platform"
  }
}