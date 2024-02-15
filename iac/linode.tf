# Definition of local variables.
locals {
  credentialsFilename = pathexpand(var.credentialsFilename)
}

# Akamai Connected Cloud provider definition.
provider "linode" {
  config_path    = local.credentialsFilename
  config_profile = "linode"
}