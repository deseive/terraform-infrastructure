remote_state {
  backend = "gcs"
  config = {
    bucket = "terraform-state-app-api-prod"
    prefix = "projects/app-api/prod"
  }
}

terraform {
  source = "git::ssh://git@github.com:deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id    = "app-api-prod"
  naming_prefix = "app-api-prod"
  region        = "europe-west3"
  domain_name   = "api-prod.example.com"
}
