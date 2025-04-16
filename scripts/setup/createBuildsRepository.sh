#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

echo -e "\nCreating Builds repository..."

repo_exists=$(gcloud builds repositories list --region ${DEFAULT_REGION} --connection ${GC_GH_CONNECTION_NAME} | grep ${GITHUB_REPO_NAME} | wc -l)
if [[ ${repo_exists} -eq 0 ]]; then
    echo "Creating builds repository: ${GITHUB_REPO_NAME}"
    gcloud builds repositories create  ${GITHUB_REPO_NAME} \
        --remote-uri=${GITHUB_REPO_URI} \
        --connection=${GC_GH_CONNECTION_NAME} \
        --region=${DEFAULT_REGION}
else
    echo "Builds repository already exists: ${GITHUB_REPO_NAME}"
fi
