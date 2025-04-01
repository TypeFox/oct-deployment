#!/bin/bash

path_sght=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_sght}/../../.env

${path_cs}/../utils/createSecret.sh "GITHUB_TOKEN"

# read GitHub token from local file not under versions control and create a secret
echo -e "\nChecking if GitHub token secret exists"
have_version=$(gcloud secrets versions list GITHUB_TOKEN | grep enabled | wc -l)
if [[ ${have_version} -eq 0 ]]; then
    echo -e "Creating a secret for GitHub token from: ${path_sght}/../../.local/gh.token"
    gcloud secrets versions add GITHUB_TOKEN --data-file=${path_sght}/../../.local/gh.token
    exec_result=$?
    if [[ ${exec_result} -ne 0 ]]; then
        echo "Failed to create secret for GitHub token. Please ensure the token is available in: ${path_sght}/../../.local/gh.token"
        exit 1
    fi
else
    echo "Secret GITHUB_TOKEN is available."
fi
