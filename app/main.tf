locals {
  vars           = yamldecode(file("../vars.yaml"))
  manifests_dir  = "${path.module}/manifests"
  manifest_files = fileset(local.manifests_dir, "*.yaml")
}
resource "kubernetes_namespace_v1" "this" {
  metadata {

    labels = {
      name                                 = "nginx"
      "pod-security.kubernetes.io/enforce" = "baseline"
    }

    name = "nginx"
  }
}

resource "kubernetes_manifest" "manifests" {
  for_each = toset(local.manifest_files)

  manifest = yamldecode(file("${local.manifests_dir}/${each.key}"))
  depends_on = [
    kubernetes_namespace_v1.this
  ]
}
