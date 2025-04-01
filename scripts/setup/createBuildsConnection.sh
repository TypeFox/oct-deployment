#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

echo -e "\nCreating Builds to repository connection..."

# update versions
secret_versions=$(gcloud secrets versions list GITHUB_TOKEN | grep enabled)
exec_result=$?

connection_exists=$(gcloud builds connections list --region ${DEFAULT_REGION} | grep ${GC_GH_CONNECTION_NAME} | wc -l)
if [[ ${connection_exists} -eq 0 && ${exec_result} -eq 0 ]]; then
    # take the latest version
    read -a versions_array <<< "${secret_versions}"
    active_secret_version="${versions_array[0]}"

    echo "Creating GitHub connection: ${GC_GH_CONNECTION_NAME}"
    gcloud builds connections create github ${GC_GH_CONNECTION_NAME} \
        --authorizer-token-secret-version=projects/${PROJECT_ID}/secrets/GITHUB_TOKEN/versions/${active_secret_version} \
        --app-installation-id=${GITHUB_APP_ID} \
        --region=${DEFAULT_REGION}
else
    echo "GitHub connection already exists: ${GC_GH_CONNECTION_NAME}"
fi
