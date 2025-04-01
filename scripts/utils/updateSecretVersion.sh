#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

secret_name=${1}

secret_versions=$(gcloud secrets versions list ${secret_name} | grep enabled)
exec_result=$?

if [[ ${exec_result} -eq 0 ]]; then
    # take the latest version
    read -a versions_array <<< "${secret_versions}"
    active_secret_version="${versions_array[0]}"

    echo "Updating secret '${secret_name}' to version: ${have_version}"
    gcloud run services update ${PROJECT_ID} --update-secrets=${secret_name}=${secret_name}:${active_secret_version}
else
    echo "No version available for secret: ${secret_name}"
fi
