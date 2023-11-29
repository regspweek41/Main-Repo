resource "kubernetes_namespace_v1" "ns" {

  metadata {
    name = "ingress-basic"

    annotations = {
      name = "sample-annotation"
    }

    labels = {
      tier = "frontend"
    }
  }
}