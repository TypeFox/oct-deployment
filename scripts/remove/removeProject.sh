#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

echo "Removing project: ${PROJECT_ID}."
echo "You can undelete within the next 30 days."

gcloud projects delete ${PROJECT_ID}
