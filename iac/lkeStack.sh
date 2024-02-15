#!/bin/bash

# Prepares the environment to execute this script.
function prepareToExecute() {
  cd .. || exit 1

  source functions.sh

  cd iac || exit 1

  export KUBECONFIG="$KUBECONFIG_FILENAME"
}

function applyLkeStack() {
  EXISTS=$($HELM_CMD repo list | grep opentelemetry)

  if [ -z "$EXISTS" ]; then
    $HELM_CMD repo add opentelemetry https://open-telemetry.github.io/opentelemetry-helm-charts
  fi

  EXISTS=$($HELM_CMD list | grep "$IDENTIFIER")

  if [ -z "$EXISTS" ]; then
    $HELM_CMD install "$IDENTIFIER" open-telemetry/opentelemetry-demo --values lke-values.yml
  fi
}

# Main function.
function main() {
  prepareToExecute
  applyLkeStack
}

main