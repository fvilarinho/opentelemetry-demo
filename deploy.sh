#!/bin/bash

# Checks the dependencies of this script.
function checkDependencies() {
  if [ -z "$TERRAFORM_CMD" ]; then
    echo "Terraform is not installed! Please install it first to continue!"

    exit 1
  fi

  if [ -z "$HELM_CMD" ]; then
    echo "Helm is not installed! Please install it first to continue!"

    exit 1
  fi
}

# Prepares the environment to execute this script.
function prepareToExecute() {
  source functions.sh

  showBanner

  cd iac || exit 1
}

# Starts the provisioning of the infrastructure based on the IaC files.
function deploy() {
  $TERRAFORM_CMD init \
                 -upgrade \
                 -migrate-state || exit 1

  $TERRAFORM_CMD plan || exit 1

  $TERRAFORM_CMD apply \
                 -auto-approve
}

# Main function.
function main() {
  prepareToExecute
  checkDependencies
  deploy
}

main