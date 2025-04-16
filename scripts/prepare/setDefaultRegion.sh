#!/bin/bash

. $(realpath $(dirname "${BASH_SOURCE[0]}"))/../../.env

gcloud config set run/region ${DEFAULT_REGION}

gcloud config list
