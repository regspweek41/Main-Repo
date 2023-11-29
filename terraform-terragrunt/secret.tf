resource "kubernetes_secret_v1" "example" {
  metadata {
    name = "acr-secret"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "project231.azurecr.io" = {
          "username" = "project231"
          "password" = "hQWV8O6ajxsMw6zUMbXlrTW+1ZpDXq8Gf2fgCbO4bj+ACRCAHUQq"
          "email"    = "rkr@gmail.com"
          "auth"     = base64encode("project231:hQWV8O6ajxsMw6zUMbXlrTW+1ZpDXq8Gf2fgCbO4bj+ACRCAHUQq")
        }
      }
    })
  }
}