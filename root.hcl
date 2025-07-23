locals {
  org_id          = "131886726058"
  billing_account = "014EA1-22311E-5A7ED1"
  region          = "europe-west1"
  tfstate_bucket  = "tfstate-org-bootstrap"
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
    bucket = "tfstate-org-bootstrap"
    prefix = "terraform/projects/${path_relative_to_include()}"
  }
}