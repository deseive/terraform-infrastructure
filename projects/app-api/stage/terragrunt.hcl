terraform {
  source = "../../../../terraform-modules/env_combined"
}

inputs = {
  project_id          = "my-gcp-project-stage"
  naming_prefix       = "app-api-stage"
  region              = "us-central1"
  location            = "us-central1"
  function_name       = "app-api-function"
  function_source_dir = "../../../my-function-source"
  runtime             = "go116"
  entry_point         = "HandleRequest"
  domain_name         = "api-stage.example.com"
}
