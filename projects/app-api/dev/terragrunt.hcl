terraform {
  # Fetch the entire terraform-modules repo, then use its env_combined/ folder
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id         = "my-gcp-project-dev"
  naming_prefix      = "app-api-dev"
  region             = "us-central1"            # for project module
  location           = "us-central1"            # for Cloud Function & API Gateway
  function_name      = "app-api-function"
  runtime            = "go116"
  entry_point        = "HandleRequest"
  domain_name        = "api-dev.example.com"
  source_archive_gcs = "gs://my-bucket-dev/app-api-function.zip"
}
