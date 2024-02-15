# Required providers definition.
terraform {
  # Remote state management definition.
  backend "s3" {
    bucket                      = "fvilarin-devops"
    key                         = "opentelemetry-demo.tfstate"
    region                      = "us-east-1"
    endpoint                    = "us-east-1.linodeobjects.com"
    skip_credentials_validation = true
  }

  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}