#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

# public access
gcloud run services add-iam-policy-binding ${PROJECT_ID} \
    --member="allUsers" \
    --role="roles/run.invoker"
