resource "kubernetes_service_v1" "svc" {
  metadata {
    name      = "frontend-svc"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name
  }
  spec {
    selector = {
       app = kubernetes_pod_v1.test.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}