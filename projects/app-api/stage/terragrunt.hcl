terraform {
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//env_combined?ref=main"
}

inputs = {
  project_id         = "my-gcp-project-stage"
  naming_prefix      = "app-api-stage"
  region             = "us-central1"
  location           = "us-central1"
  function_name      = "app-api-function"
  runtime            = "go116"
  entry_point        = "HandleRequest"
  domain_name        = "api-stage.example.com"
  source_archive_gcs = "gs://my-bucket-stage/app-api-function.zip"
}
