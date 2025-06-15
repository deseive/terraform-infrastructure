locals {
  org_id          = "131886726058"
  billing_account = "014EA1-22311E-5A7ED1"
  region          = "europe-west1"
  
  
  apis = [
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
    "servicenetworking.googleapis.com"
  ]
}