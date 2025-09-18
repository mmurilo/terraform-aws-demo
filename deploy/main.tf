locals {
  vars                = yamldecode(file("../vars.yaml"))
  manifests_dir       = "${path.module}/manifests"
  manifest_files      = fileset(local.manifests_dir, "*.yaml")
  manifests_dir_prod  = "${path.module}/manifests-prod"
  manifest_files_prod = fileset(local.manifests_dir_prod, "*.yaml")
}
resource "kubernetes_namespace_v1" "dev" {
  metadata {

    labels = {
      name                                 = "hello"
      environment                          = "dev"
      "pod-security.kubernetes.io/enforce" = "baseline"
      "kubernetes.io/metadata.name"        = "hello"
    }

    name = "hello"
  }
}

resource "kubernetes_manifest" "dev" {
  for_each = toset(local.manifest_files)

  manifest = yamldecode(file("${local.manifests_dir}/${each.key}"))
  depends_on = [
    kubernetes_namespace_v1.dev
  ]
}

## Prod

resource "kubernetes_namespace_v1" "prod" {
  metadata {

    labels = {
      name                                 = "hello-prod"
      environment                          = "prod"
      "pod-security.kubernetes.io/enforce" = "baseline"
      "kubernetes.io/metadata.name"        = "hello-prod"
    }

    name = "hello-prod"
  }
}

resource "kubernetes_manifest" "prod" {
  for_each = toset(local.manifest_files_prod)

  manifest = yamldecode(file("${local.manifests_dir_prod}/${each.key}"))
  depends_on = [
    kubernetes_namespace_v1.prod
  ]
}
