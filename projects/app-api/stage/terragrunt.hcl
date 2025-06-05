remote_state {
  backend = "gcs"
  config = {
    bucket = "terraform-state-app-api-stage"
    prefix = "projects/app-api/stage"
  }
}

terraform {
  source = "git::ssh://git@github.com:deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id    = "app-api-stage"
  naming_prefix = "app-api-stage"
  region        = "europe-west3"
  domain_name   = "api-stage.example.com"
}
