terraform {
  required_providers {
    helm = {
      source  = "opentofu/helm"
      version = "~> 3.1.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}
