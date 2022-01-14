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

resource kubernetes_pod "sample_pod" {
  metadata {
    name = "nginx-pod"
    namespace = "terraform-namespace"
    labels = {
      "app"="nginx-tf-pod"
    }
  }

  spec {
    container {
      name = "nginx-tf-cn"
      image = "nginx"
    }
  }
}
