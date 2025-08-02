include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  #source = "git::ssh://git@github.com/deseive/terraform-modules.git//project?ref=main"
  source = "/Users/roban/git/terraform-modules/project"
}

inputs = {
  name        = "n8n"
  env_code    = "dev"
  environment = "development"
  random_suffix   = "6hf4"
  alert_email = "andredeseive@gmail.com"
  iam_impersonation   = "user:gc@roban.de"
  terraform_bootstrap_sa = "terraform@bootstrap-seed-project.iam.gserviceaccount.com"

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com",
    "certificatemanager.googleapis.com",
    "dns.googleapis.com",
    "appengine.googleapis.com",
    "storage.googleapis.com",
    "iap.googleapis.com",
    "secretmanager.googleapis.com",
    "vpcaccess.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "containeranalysis.googleapis.com",
    "docs.googleapis.com",
	  "drive.googleapis.com",
	  "gmail.googleapis.com",
  ]
}