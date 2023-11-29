resource "kubernetes_pod_v1" "test" {
  metadata {
    name      = "terraform-example"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name
    labels = {
      app = "MyExampleApp"
    }
  }

  spec {
    container {
      image = "project231.azurecr.io/samples/nginx:latests"
      name  = "example"

      env {
        name  = "environment"
        value = "test"
      }

      port {
        container_port = 80
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }
    image_pull_secrets {
      name = "acr-secret"
    }

  }
}
