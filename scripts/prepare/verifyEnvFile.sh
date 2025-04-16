#!/bin/bash

path_vef=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_vef}/../../.env

status=0

${path_vef}/../utils/checkProperty.sh "PROJECT_ID" ${PROJECT_ID}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "BILLING_ACCOUNT_ID" ${BILLING_ACCOUNT_ID}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "SERVICE_ACCOUNT_NAME" ${SERVICE_ACCOUNT_NAME}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "DEFAULT_REGION" ${DEFAULT_REGION}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "GITHUB_REPO_NAME" ${GITHUB_REPO_NAME}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "GITHUB_REPO_URI" ${GITHUB_REPO_URI}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "GITHUB_APP_ID" ${GITHUB_APP_ID}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "GC_GH_CONNECTION_NAME" ${GC_GH_CONNECTION_NAME}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_BASE_URL" ${OCT_BASE_URL}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_SERVER_OWNER" ${OCT_SERVER_OWNER}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_ACTIVATE_SIMPLE_LOGIN" ${OCT_ACTIVATE_SIMPLE_LOGIN}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_LOGIN_PAGE_URL" ${OCT_LOGIN_PAGE_URL}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_LOGIN_SUCCESS_URL" ${OCT_LOGIN_SUCCESS_URL}
status=$((status + $?))

${path_vef}/../utils/checkProperty.sh "OCT_REDIRECT_URL_WHITELIST" ${OCT_REDIRECT_URL_WHITELIST}
status=$((status + $?))

if [[ ${status} -eq 0 ]]; then
    echo "Environment file contains all required key value pairs."
else
    echo "Environment file is not valid. Check the printed errors."
fi
