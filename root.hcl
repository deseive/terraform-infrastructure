locals {
  org_id          = "131886726058"
  billing_account = "014EA1-22311E-5A7ED1"
  region          = "europe-west3"

  apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com", # falls du Cloud Run stattdessen nutzt
  ]
}