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
  project_number  = "946357259966"
  domain          = "api-dev.linorino.de"
  state_bucket    = "tfstate-org-bootstrap"
  image           = "us-docker.pkg.dev/cloudrun/container/hello"
  iap_member      = "user:gc@roban.de"
  vpc_name        = "default"
  database_version = "POSTGRES_17"
  database_tier   = "db-f1-micro"

  cloud_run_sa_email = "cloud-run-deployer@${local.project_id}.iam.gserviceaccount.com"
  cloud_run_min_instances = 2
  cloud_run_max_instances = 3

  # 🔐 Secrets required by n8n service
  secrets = [
    #openssl rand -base64 24 | cut -c1-32
    "n8n_encryption_key",
    "db_user",
    "db_password",
    "db_name",
    "n8n_jwt_secret"
  ]

  # 🪣 Bucket used for persistent file storage in n8n
  n8n_bucket_name = "${local.project_id}-n8n-data"
  n8n_runners_enabled = true
  n8n_runners_mode = "internal"

}

terraform {
  #source = "git::ssh://git@github.com/deseive/terraform-modules.git//cloud-run?ref=main"
  source = "/Users/roban/git/terraform-modules/cloud-run"
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
  cloud_run_min_instances = local.cloud_run_min_instances
  cloud_run_max_instances = local.cloud_run_max_instances
  vpc_name            = local.vpc_name
  database_version    = local.database_version
  database_tier       = local.database_tier

  # 🆕 Provide secrets and bucket name
  secrets             = local.secrets
  n8n_bucket_name     = local.n8n_bucket_name
  n8n_runners_enabled = local.n8n_runners_enabled
  n8n_runners_mode    = local.n8n_runners_mode
}