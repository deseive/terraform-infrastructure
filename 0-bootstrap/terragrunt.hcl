include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  #source = "git::ssh://git@github.com/deseive/terraform-modules.git//bootstrap?ref=main"
  source = "/Users/roban/git/terraform-modules/bootstrap"

}

inputs = {
  project_name       = "Bootstrap Seed Project"
  project_id         = "bootstrap-seed-project"
  bucket_name        = "bootstrap-org-tfstate"
  bucket_location    = "europe-west1"
  state_writer_iam   = "user:gc@roban.de"
  budget_amount    = 100
  budget_currency  = "EUR"
  budget_threshold = 0.8
}

remote_state {
  backend = "local"

  config = {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}