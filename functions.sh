#!/bin/bash

# Shows the labels.
function showLabel() {
  if [[ "$0" == *"undeploy.sh"* ]]; then
    echo "** Undeploy **"
  elif [[ "$0" == *"deploy.sh"* ]]; then
    echo "** Deploy **"
  fi

  echo
}

# Shows the banner.
function showBanner() {
  if [ -f banner.txt ]; then
    cat banner.txt
  fi

  showLabel
}

# Prepares the environment to execute the commands of this script.
function prepareToExecute() {
  # Mandatory binaries.
  export TERRAFORM_CMD=$(which terraform)
  export HELM_CMD=$(which helm)

  # Mandatory files/paths.
  export WORK_DIR="$PWD"/iac
  export CREDENTIALS_FILENAME="$WORK_DIR"/.credentials
  export SETTINGS_FILENAME="$WORK_DIR"/settings.json
  export IDENTIFIER=opentelemetry-demo
  export KUBECONFIG_FILENAME="$WORK_DIR"/.kubeconfig

  export TF_VAR_credentialsFilename="$CREDENTIALS_FILENAME"
  export TF_VAR_settingsFilename="$SETTINGS_FILENAME"
  export TF_VAR_identifier="$IDENTIFIER"
  export TF_VAR_kubeconfigFilename="$KUBECONFIG_FILENAME"
}

prepareToExecute