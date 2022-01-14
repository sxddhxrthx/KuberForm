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

resource kubernetes_deployment "sample-deploy" {

  depends_on = [kubernetes_namespace.tf_namespace]

  metadata {
    name = var.deployment_name
    namespace = var.namespace
    labels = {
      "app"="nginx-tf-deploy"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
          "app" = "nginx-tf-pod"
      }
    }

    template {

      metadata {
        name = "nginx-pods"
        labels = {
          "app" = "nginx-tf-pod"
        }
      }

      spec {
        container {
          name = "nginx-cn"
          image = "nginx"
        }
      }
    }
  }
}

output "deployment_id" {
  value = kubernetes_deployment.sample-deploy.metadata[0].uid
}
