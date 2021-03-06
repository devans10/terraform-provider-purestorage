resource "kubernetes_secret" "tfpf-regsecret" {
  metadata {
    name = "tfpf-regsecret"
  }

  data = {
    ".dockerconfigjson" = "${file("~/.docker/config.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_deployment" "terraform-provider-flash-website" {
  metadata {
    name = "terraform-provider-flash-website"
    labels = {
      app = "terraform-provider-flash-website"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "terraform-provider-flash-website"
      }
    }

    template {
      metadata {
        labels = {
          app = "terraform-provider-flash-website"
        }
      }

      spec {
        container {
           name = "terraform-provider-flash-website"
           image = var.image
           image_pull_policy = "Always"
           port {
             container_port = "80"
           }
         }
         image_pull_secrets {
           name = kubernetes_secret.tfpf-regsecret.metadata.0.name
         }
       }
     }
   }
}


resource "kubernetes_service" "terraform-provider-flash-website" {
  metadata {
    name = "terraform-provider-flash-website"
  }
  spec {
    selector = {
      app = kubernetes_deployment.terraform-provider-flash-website.metadata.0.labels.app
    }
    port {
      port = 80
      target_port = 80
    }
  }
}


