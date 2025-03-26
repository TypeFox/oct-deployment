#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

role_required=${1}
account_name=${2}

echo -e "\nChecking '${account_name}' for IAM permissions. Required role: ${role_required}"
needs_iam_policy=$(gcloud projects get-iam-policy ${PROJECT_ID} | grep -B 2 ${role_required} | grep ${account_name} | wc -l)
if [[ ${needs_iam_policy} -eq 0 ]]; then
    echo "Updating IAM policy '${role_required}' for: ${account_name}"
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
        --member="serviceAccount:${account_name}" \
        --role=${role_required}
else
    echo "No IAM policy '${role_required}' update needed for: ${account_name}"
fi
