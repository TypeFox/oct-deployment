#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

echo -e "\nEnabling required APIs..."

echo -e "\nEnabling billing for project: ${PROJECT_ID}"
gcloud billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT_ID

echo -e "\nEnabling Cloud Run API"
gcloud services enable run.googleapis.com

echo -e "\nEnabling Cloud Build API"
gcloud services enable cloudbuild.googleapis.com

echo -e "\nEnabling Secret Manager API"
gcloud services enable secretmanager.googleapis.com

echo -e "\nEnabling IAM Credentials API"
gcloud services enable iamcredentials.googleapis.com
