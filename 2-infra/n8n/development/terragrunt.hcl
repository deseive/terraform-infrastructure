include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  # source = "git::ssh://git@github.com/deseive/terraform-modules.git//infra?ref=main"
  source = "/Users/roban/git/terraform-modules/infra"
}

inputs = {
  name            = "n8n"
  env_code        = "dev"
  environment     = "development"
  random_suffix   = "8d2w"

  # infra-specific settings
  domain            = "n8n-dev.roban.de"

  secrets           = [
    "n8n_encryption_key",
    "db_user",
    "db_password",
    "db_name",
    "n8n_jwt_secret",
  ]
  secrets_accessor  = "user:gc@roban.de"
}