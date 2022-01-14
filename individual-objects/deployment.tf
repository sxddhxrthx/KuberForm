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

resource kubernetes_deployment "sample-deploy" {
  metadata {
    name = "nginx-deployment"
    namespace = "terraform-namespace"
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
