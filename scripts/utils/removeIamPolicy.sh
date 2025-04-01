#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

role_required=${1}
account_name=${2}

echo -e "\nChecking '${account_name}' for IAM permissions. Required role: ${role_required}"
iam_policy_removal_needed=$(gcloud projects get-iam-policy ${PROJECT_ID} | grep -B 2 ${role_required} | grep ${account_name} | wc -l)
if [[ ${iam_policy_removal_needed} -eq 1 ]]; then
    echo "Removing IAM policy '${role_required}' for: ${account_name}"
    gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
        --member="serviceAccount:${account_name}" \
        --role=${role_required}
else
    echo "No IAM policy '${role_required}' found for: ${account_name}"
fi
