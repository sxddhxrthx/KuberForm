terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/localconfig"
}

resource kubernetes_namespace "tf_namespace" {
  metadata {
    name = var.namespace
  }
}
