include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "/Users/roban/git/terraform-modules/namespace"
}

dependency "gke" {
  config_path = "../../../2-infra/gke/development"
}

inputs = {
  name             = "n8n"
  env_code         = "dev"
  random_suffix    = "6hf4"
  environment               = "development"
  namespace                 = "n8n"
  k8s_service_account       = "n8n-sa"
  gcp_service_account_email = "n8n-workload@gke-dev-9dh3.iam.gserviceaccount.com"
  project_id                = dependency.gke.outputs.project_id
  cluster_endpoint          = dependency.gke.outputs.cluster_endpoint
  cluster_ca_certificate    = dependency.gke.outputs.cluster_ca_certificate
}