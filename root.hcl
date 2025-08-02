locals {
  org_id          = "131886726058"
  billing_account = "014EA1-22311E-5A7ED1"
  region          = "europe-west1"
  tfstate_bucket  = "bootstrap-org-tfstate"
}

inputs = {
  org_id          = local.org_id
  billing_account = local.billing_account
  region          = local.region
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    project = "bootstrap-seed-project"
    bucket   = "bootstrap-org-tfstate"
    location = "europe-west1"
    prefix   = "terraform/projects/${path_relative_to_include()}"
  }
}