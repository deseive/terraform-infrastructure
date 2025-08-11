include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "/Users/roban/git/terraform-modules/app"
}


dependency "gke" {
  config_path = "../../../2-infra/gke/development"
}

inputs = {
  name                  = "n8n"
  env_code              = "dev"
  random_suffix         = "6hf4"
  environment           = "development"
  namespace             = "n8n"
  k8s_service_account   = "n8n-sa"
  auth_user             = "admin"
  auth_pass             = "supersecret"

  cluster_endpoint       = dependency.gke.outputs.cluster_endpoint
  cluster_ca_certificate = dependency.gke.outputs.cluster_ca_certificate
  gke_project_id         = dependency.gke.outputs.project_id
  shared_ingress_ip_name = dependency.gke.outputs.shared_ingress_ip_name

  domain                = "n8n-dev.roban.de"
  container_port        = "5678"
  image                 = "docker.io/n8nio/n8n:latest"
  container_resources = {
    limits = {
      memory = "512Mi"
      cpu    = "500m"
    }
    requests = {
      memory = "256Mi"
      cpu    = "250m"
    }
  }

  liveness_probe = {
    path                  = "/healthz"
    port                  = "5678"
    initial_delay_seconds = 10
    period_seconds        = 10
  }

  readiness_probe = {
    path                  = "/healthz"
    port                  = "5678"
    initial_delay_seconds = 5
    period_seconds        = 5
  }

  envs = []
}
