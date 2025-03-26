#!/bin/bash

path_cbt=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_cbt}/../../.env

echo -e "\nCreating a build trigger for GitHub app"

service_account=${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com

# Create cloudbuild.yaml by replacing placeholders in cloudbuild.template.yaml
sed "s/%DEPLOY_REGION%/${DEFAULT_REGION}/g" ${path_cbt}/../../config/templates/cloudbuild.template.yaml > ${path_cbt}/../../cloudbuild.tmp
sed "s/%SERVICE_NAME%/${PROJECT_ID}/g" ${path_cbt}/../../cloudbuild.tmp > ${path_cbt}/../../cloudbuild.yaml
mv ${path_cbt}/../../cloudbuild.yaml ${path_cbt}/../../cloudbuild.tmp
sed "s/%SERVICE_ACCOUNT%/${service_account}/g" ${path_cbt}/../../cloudbuild.tmp > ${path_cbt}/../../cloudbuild.yaml
rm ${path_cbt}/../../cloudbuild.tmp

trigger_name="${GITHUB_REPO_NAME}-trigger"
needs_trigger=$(gcloud builds triggers list --region="${DEFAULT_REGION}" | grep -i ${trigger_name} | wc -l)

repo_path="projects/${PROJECT_ID}/locations/${DEFAULT_REGION}/connections/${GC_GH_CONNECTION_NAME}/repositories/${GITHUB_REPO_NAME}"
if [[ ${needs_trigger} -eq 0 ]]; then
    echo "Creating trigger: ${trigger_name} for: ${repo_path}"
    gcloud builds triggers create github --name="${trigger_name}" \
        --repository="${repo_path}" \
        --branch-pattern="^main$" \
        --inline-config=${path_cbt}/../../cloudbuild.yaml \
        --region="${DEFAULT_REGION}" \
        --service-account="projects/${PROJECT_ID}/serviceAccounts/${service_account}"
else
    echo "Trigger '${trigger_name}' for '${repo_path}' already exists."
fi
