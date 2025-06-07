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
  random_suffix = "5h8g"

  project_name  = "App API Dev Project"
  project_id    = "${local.project}-${local.env}-${local.random_suffix}"
  state_bucket  = "${local.project_id}-tfstate"
}

terraform {
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//bootstrap?ref=main"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket  = "${local.state_bucket}"
    prefix  = "terraform/state"
  }
}
EOF
}

inputs = {
  project_id      = local.project_id
  project_name    = local.project_name
  org_id          = local.org_id
  billing_account = local.billing_account
  region          = local.region
  apis            = local.apis
}