terraform {
  source = "git@github.com:deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id          = "my-gcp-project-prod"
  naming_prefix       = "app-api-prod"
  region              = "us-central1"
  location            = "us-central1"
  function_name       = "app-api-function"
  function_source_dir = "../../../my-function-source"
  runtime             = "go116"
  entry_point         = "HandleRequest"
  domain_name         = "api.example.com"
}
