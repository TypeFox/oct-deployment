#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

var_name=${1}
var_value=${2}

if [[ "${var_value}" != "unknown" ]]; then
  echo "Updating ${var_name} to: ${var_value}"
  gcloud run services update ${PROJECT_ID} --update-env-vars=${var_name}=${var_value}
else
  echo "${var_name} has default value: ${var_value}"
fi
