# Definition of local variables.
locals {
  settingsFilename   = pathexpand(var.settingsFilename)
  settings           = jsondecode(file(local.settingsFilename))
  kubeconfigFilename = pathexpand(var.kubeconfigFilename)
}

# Creates a LKE cluster.
resource "linode_lke_cluster" "default" {
  label       = var.identifier
  tags        = local.settings.tags
  region      = local.settings.infrastructure.region
  k8s_version = "1.28"

  # Pool definition.
  pool {
    type  = local.settings.infrastructure.type
    count = 1
  }
}

# Downloads the kubeconfig file to be able to connect in the LKE cluster after the provisioning.
resource "local_sensitive_file" "kubeconfig" {
  filename        = local.kubeconfigFilename
  content_base64  = linode_lke_cluster.default.kubeconfig
  file_permission = "600"
  depends_on      = [ linode_lke_cluster.default ]
}