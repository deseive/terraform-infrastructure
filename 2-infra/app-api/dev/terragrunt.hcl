include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  root_config     = read_terragrunt_config(find_in_parent_folders("root.hcl"))
  org_id          = local.root_config.locals.org_id
  billing_account = local.root_config.locals.billing_account
  region          = local.root_config.locals.region
  apis            = local.root_config.locals.apis

  env           = "dev"
  project       = "app-api"
  random_suffix = "8d2w"

  project_id   = "${local.project}-${local.env}-${local.random_suffix}"
  domain       = "api.roban.de"
  state_bucket = "tfstate-org-bootstrap"
}

terraform {
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//infra?ref=main"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket  = "${local.state_bucket}"
    prefix  = "${local.project_id}/infra.tfstate"
  }
}
EOF
}

inputs = {
  project_id = local.project_id
  region     = local.region
  domain     = local.domain
}