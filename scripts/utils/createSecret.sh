#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

secret_name=${1}

secrets_list=$(gcloud secrets list)
have_secret=$(echo $secrets_list | grep ${secret_name} | wc -l)

if [[ ${have_secret} -eq 0 ]]; then
    echo "Creating secret: ${secret_name}"
    gcloud secrets create ${secret_name} --replication-policy="automatic"
else
    echo "Secret ${secret_name} already exists."
fi
