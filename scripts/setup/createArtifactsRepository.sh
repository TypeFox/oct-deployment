#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

echo -e "\nCreating Artifacts repository..."

default_repo_name="cloud-run-source-deploy"
repo_exists=$(gcloud artifacts repositories list --location=${DEFAULT_REGION} | grep ${default_repo_name} | wc -l)
if [[ ${repo_exists} -eq 0 ]]; then
    echo "Creating artifacts repository: ${default_repo_name}"
    gcloud artifacts repositories create ${default_repo_name} \
        --repository-format="docker" \
        --location=${DEFAULT_REGION} \
        --description="Docker repository"
else
    echo "Artifacts repository already exists: ${default_repo_name}"
fi
