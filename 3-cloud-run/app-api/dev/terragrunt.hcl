include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  root_config     = read_terragrunt_config(find_in_parent_folders("root.hcl"))
  org_id          = local.root_config.locals.org_id
  billing_account = local.root_config.locals.billing_account
  region          = local.root_config.locals.region
  apis            = local.root_config.locals.apis

  env             = "dev"
  project         = "app-api"
  random_suffix   = "8d2w"

  project_id      = "${local.project}-${local.env}-${local.random_suffix}"
  project_number  = "946357259966x"
  domain          = "api-dev.linorino.de"
  state_bucket    = "tfstate-org-bootstrap"
  image           = "gcr.io/cloudrun/hello"
  iap_member      = "user:gc@roban.de"
  vpc_name        = "default"
  database_version = "POSTGRES_17"

  cloud_run_sa_email = "cloud-run-deployer@${local.project_id}.iam.gserviceaccount.com"

  # 🔐 Secrets required by n8n service
  secrets = [
    "db_user",
    "db_password",
    "db_name",
    "n8n_jwt_secret"
  ]

  # 🪣 Bucket used for persistent file storage in n8n
  n8n_bucket_name = "${local.project_id}-n8n-data"
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
  project_id          = local.project_id
  project_number      = local.project_number
  region              = local.region
  domain              = local.domain
  name                = "api"
  image               = local.image
  iap_member          = local.iap_member
  cloud_run_sa_email  = local.cloud_run_sa_email
  vpc_name            = local.vpc_name
  database_version    = local.database_version

  # 🆕 Provide secrets and bucket name
  secrets             = local.secrets
  n8n_bucket_name     = local.n8n_bucket_name
}