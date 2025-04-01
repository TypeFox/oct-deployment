#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

# check if project name was given and continue if it is
found_project=$(gcloud projects list --filter ${PROJECT_ID} | grep ${PROJECT_ID} | wc -l)
exec_result=$?
# general error
if [[ ${exec_result} -eq 1 ]]; then exit 1; fi

if [[ ${found_project} -gt 0 ]]; then
    echo "Project ${PROJECT_ID} already exists."
else
    echo "Project ${PROJECT_ID} does not exists."    
    
    echo "Creating project ${PROJECT_ID}..."
    result=$(gcloud projects create ${PROJECT_ID})
fi

gcloud config set project ${PROJECT_ID}

gcloud config list
