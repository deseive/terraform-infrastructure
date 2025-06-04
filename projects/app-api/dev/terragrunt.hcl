terraform {
  source = "../../../../terraform-modules/env_combined"
}

inputs = {
  project_id          = "my-gcp-project-dev"
  naming_prefix       = "app-api-dev"
  region              = "us-central1"           # for project module
  location            = "us-central1"           # for Cloud Function & API Gateway
  function_name       = "app-api-function"
  function_source_dir = "../../../my-function-source"  # relative path to your Go code
  runtime             = "go116"
  entry_point         = "HandleRequest"
  domain_name         = "api-dev.example.com"
}
