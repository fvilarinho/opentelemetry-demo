# Applies the stack services and deployments.
resource "null_resource" "applyLkeStack" {
  provisioner "local-exec" {
    quiet   = true
    command = "./lkeStack.sh"
  }

  depends_on = [ linode_lke_cluster.default ]
}