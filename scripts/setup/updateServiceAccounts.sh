#!/bin/bash

path_csa=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_csa}/../../.env

# https://cloud.google.com/iam/docs/service-accounts-create

service_account=${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com
sa_exists=$(gcloud iam service-accounts list | grep ${SERVICE_ACCOUNT_NAME} | wc -l)
PN=$(gcloud projects list --filter="${PROJECT_ID}" --format="value(PROJECT_NUMBER)")

if [[ ${sa_exists} -eq 0 ]]; then
    echo "Creating service account: ${service_account}"
    result=$(gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} \
        --display-name="Cloud Build Service Account" \
        --description="Cloud Build Service Account")
else
    echo "Service account '${service_account}' already exists."
fi

# Needed for "gcloud builds connections create github" (createBuildsConnection.sh)
${path_csa}/../utils/addIamPolicy.sh "roles/secretmanager.secretAccessor" "service-${PN}@gcp-sa-cloudbuild.iam.gserviceaccount.com"

# general permissions for build, push, deploy (=run service update)
${path_csa}/../utils/addIamPolicy.sh "roles/logging.logWriter" ${service_account}
${path_csa}/../utils/addIamPolicy.sh "roles/artifactregistry.writer" ${service_account}
${path_csa}/../utils/addIamPolicy.sh "roles/run.admin" ${service_account}
${path_csa}/../utils/addIamPolicy.sh "roles/run.serviceAgent" ${service_account}
