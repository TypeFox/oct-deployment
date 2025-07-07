#!/bin/bash

path_usv=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_usv}/../../.env

${path_usv}/../utils/updateEnvVar.sh "OCT_BASE_URL" "${OCT_BASE_URL}"
${path_usv}/../utils/updateEnvVar.sh "OCT_SERVER_OWNER" "${OCT_SERVER_OWNER}"
${path_usv}/../utils/updateEnvVar.sh "OCT_ACTIVATE_SIMPLE_LOGIN" "${OCT_ACTIVATE_SIMPLE_LOGIN}"
${path_usv}/../utils/updateEnvVar.sh "OCT_LOGIN_PAGE_URL" "${OCT_LOGIN_PAGE_URL}"
${path_usv}/../utils/updateEnvVar.sh "OCT_LOGIN_SUCCESS_URL" "${OCT_LOGIN_SUCCESS_URL}"

${path_usv}/../utils/createSecret.sh "OCT_JWT_PRIVATE_KEY"
${path_usv}/../utils/createSecret.sh "OCT_OAUTH_GITHUB_CLIENTID"
${path_usv}/../utils/createSecret.sh "OCT_OAUTH_GITHUB_CLIENTSECRET"
${path_usv}/../utils/createSecret.sh "OCT_OAUTH_GOOGLE_CLIENTID"
${path_usv}/../utils/createSecret.sh "OCT_OAUTH_GOOGLE_CLIENTSECRET"

${path_usv}/../utils/updateSecretVersion.sh "OCT_JWT_PRIVATE_KEY"
${path_usv}/../utils/updateSecretVersion.sh "OCT_OAUTH_GITHUB_CLIENTID"
${path_usv}/../utils/updateSecretVersion.sh "OCT_OAUTH_GITHUB_CLIENTSECRET"
${path_usv}/../utils/updateSecretVersion.sh "OCT_OAUTH_GOOGLE_CLIENTID"
${path_usv}/../utils/updateSecretVersion.sh "OCT_OAUTH_GOOGLE_CLIENTSECRET"
