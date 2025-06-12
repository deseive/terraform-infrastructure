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
  project_number = "946357259966"
  domain       = "api-dev.linorino.de"
  state_bucket = "tfstate-org-bootstrap"
  # Change after first Github Actions run
  image        = "gcr.io/cloudrun/hello"
  iap_member   = "user:gc@roban.de"
}

terraform {
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//cloud-run?ref=main"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket  = "${local.state_bucket}"
    prefix  = "${local.project_id}/cloud-run.tfstate"
  }
}
EOF
}

inputs = {
  project_id = local.project_id
  region     = local.region
  domain     = local.domain
  project_number = local.project_number
  name       = "api"
  image      = local.image
  iap_member = local.iap_member

}