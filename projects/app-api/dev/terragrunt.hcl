remote_state {
  backend = "gcs"
  config = {
    bucket = "terraform-state-app-api-dev"
    prefix = "projects/app-api/dev"
  }
}

terraform {
  source = "git::ssh://git@github.com:deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id    = "app-api-dev"
  naming_prefix = "app-api-dev"
  region        = "europe-west3"
  domain_name   = "api-dev.example.com"
}
