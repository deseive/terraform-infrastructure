include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "/Users/roban/git/terraform-modules/app-infra" # Adjust if you use remote source
}

dependency "gke" {
  config_path = "../../../2-infra/gke/development"
}

inputs = {
  name             = "n8n"
  env_code         = "dev"
  random_suffix    = "6hf4"
  secrets           = [
    "N8N_ENCRYPTION_KEY",
  ]
  bucket_object_admin  = "user:gc@roban.de"
  gke_project_id       = dependency.gke.outputs.project_id
}