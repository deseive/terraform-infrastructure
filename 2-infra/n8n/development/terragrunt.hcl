include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::ssh://git@github.com/deseive/terraform-modules.git//infra?ref=main"
}

inputs = {
  name            = "n8n"
  env_code        = "dev"
  environment     = "development"
  random_suffix   = "8d2w"

  domain            = "n8n-dev.roban.de"

  secrets           = [
    "n8n_encryption_key",
  ]

  secrets_accessor  = "user:gc@roban.de"
}