terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }

  backend "local" {}   #state stored as terraform.tfstate in this folder
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kube_context  #e.g. "minikube"
}

# ── 1. Namespace ─────────────────────────────────────────
resource "kubernetes_namespace" "apps" {
  metadata {
    name = "apps"
    labels = {
      managed-by  = "terraform"
      environment = var.environment
    }
  }
}

# ── 2. Secret ─────────────────────────────────────────────
resource "kubernetes_secret" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.apps.metadata[0].name
  }

  type = "Opaque"

  data = {
    ENV = var.environment   #Terraform auto-base64-encodes this value
  }
}